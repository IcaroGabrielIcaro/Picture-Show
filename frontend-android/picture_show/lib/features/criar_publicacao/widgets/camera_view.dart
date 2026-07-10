import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:picture_show/theme/app_spacing.dart';

class CameraView extends StatefulWidget {
  final ValueChanged<File> onImagemSelecionada;

  const CameraView({super.key, required this.onImagemSelecionada});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController? _controller;

  final ImagePicker _picker = ImagePicker();

  List<CameraDescription> _cameras = [];

  int _cameraIndex = 0;

  bool _capturando = false;

  @override
  void initState() {
    super.initState();
    _carregarCameras();
  }

  Future<void> _carregarCameras() async {
    try {
      _cameras = await availableCameras();

      if (_cameras.isEmpty) {
        throw Exception('Nenhuma câmera encontrada.');
      }

      final backCameraIndex = _cameras.indexWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
      );

      await _inicializarCamera(backCameraIndex == -1 ? 0 : backCameraIndex);
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível inicializar a câmera.')),
      );
    }
  }

  Future<void> _inicializarCamera(int index) async {
    final antigo = _controller;

    _controller = null;

    if (mounted) {
      setState(() {});
    }

    await antigo?.dispose();

    final controller = CameraController(
      _cameras[index],
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await controller.initialize();

    if (!mounted) {
      await controller.dispose();
      return;
    }

    setState(() {
      _controller = controller;
      _cameraIndex = index;
    });
  }

  Future<void> _trocarCamera() async {
    if (_capturando) return;

    final atual = _cameras[_cameraIndex];

    final CameraLensDirection novaDirecao =
        atual.lensDirection == CameraLensDirection.back
        ? CameraLensDirection.front
        : CameraLensDirection.back;

    final novoIndex = _cameras.indexWhere(
      (camera) => camera.lensDirection == novaDirecao,
    );

    if (novoIndex == -1) return;

    await _inicializarCamera(novoIndex);
  }

  Future<void> _tirarFoto() async {
    final controller = _controller;

    if (controller == null || !controller.value.isInitialized || _capturando) {
      return;
    }

    setState(() {
      _capturando = true;
    });

    try {
      final foto = await controller.takePicture();

      if (!mounted) return;

      widget.onImagemSelecionada(File(foto.path));
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Erro ao capturar a foto.')));
    } finally {
      if (mounted) {
        setState(() {
          _capturando = false;
        });
      }
    }
  }

  Future<void> _abrirGaleria() async {
    try {
      final imagem = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
      );

      if (imagem == null || !mounted) return;

      widget.onImagemSelecionada(File(imagem.path));
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao selecionar imagem da galeria.')),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    if (controller == null || !controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        Positioned.fill(child: CameraPreview(controller)),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            color: Colors.black54,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  iconSize: 26,
                  color: Colors.white,
                  tooltip: 'Galeria',
                  onPressed: _capturando ? null : _abrirGaleria,
                  icon: const Icon(Icons.photo_library_outlined),
                ),

                GestureDetector(
                  onTap: _capturando ? null : _tirarFoto,
                  child: Container(
                    width: 74,
                    height: 74,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 5),
                    ),
                    child: _capturando
                        ? const Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Colors.white,
                            ),
                          )
                        : null,
                  ),
                ),

                IconButton(
                  iconSize: 26,
                  color: Colors.white,
                  tooltip: 'Alternar câmera',
                  onPressed: _capturando ? null : _trocarCamera,
                  icon: const Icon(Icons.cameraswitch_outlined),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
