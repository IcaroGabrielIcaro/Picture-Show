import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraView extends StatefulWidget {
  final ValueChanged<File> onImagemSelecionada;

  const CameraView({super.key, required this.onImagemSelecionada});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController? _controller;

  List<CameraDescription> _cameras = [];

  final ImagePicker _picker = ImagePicker();

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _inicializarCamera();
  }

  Future<void> _inicializarCamera() async {
    _cameras = await availableCameras();

    _controller = CameraController(_cameras.first, ResolutionPreset.high);

    await _controller!.initialize();

    setState(() {
      _loading = false;
    });
  }

  Future<void> _tirarFoto() async {
    final foto = await _controller!.takePicture();

    widget.onImagemSelecionada(File(foto.path));
  }

  Future<void> _abrirGaleria() async {
    final imagem = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );

    if (imagem == null) return;

    widget.onImagemSelecionada(File(imagem.path));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        Positioned.fill(child: CameraPreview(_controller!)),

        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            color: Colors.black54,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  iconSize: 34,
                  color: Colors.white,
                  onPressed: _abrirGaleria,
                  icon: const Icon(Icons.photo_library),
                ),

                GestureDetector(
                  onTap: _tirarFoto,
                  child: Container(
                    width: 74,
                    height: 74,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 5),
                    ),
                  ),
                ),

                const SizedBox(width: 34),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
