import 'dart:io';

import 'package:flutter/material.dart';
import 'package:picture_show/widgets/header/header.dart';
import 'package:picture_show/widgets/layout/app_scaffold.dart';
import 'package:picture_show/widgets/navigation/navigation_tab.dart';

import 'widgets/camera_view.dart';
import 'widgets/confirmar_publicacao.dart';

class CriarPublicacaoPage extends StatefulWidget {
  const CriarPublicacaoPage({super.key});

  @override
  State<CriarPublicacaoPage> createState() => _CriarPublicacaoPageState();
}

class _CriarPublicacaoPageState extends State<CriarPublicacaoPage> {
  File? _imagem;

  void _onImagemSelecionada(File imagem) {
    setState(() {
      _imagem = imagem;
    });
  }

  void _voltarParaCamera() {
    setState(() {
      _imagem = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentTab: NavigationTab.create,
      appBar: const Header(title: 'Nova publicação'),
      child: _imagem == null
          ? CameraView(onImagemSelecionada: _onImagemSelecionada)
          : ConfirmarPublicacao(
              imagem: _imagem!,
              onCancelar: _voltarParaCamera,
            ),
    );
  }
}
