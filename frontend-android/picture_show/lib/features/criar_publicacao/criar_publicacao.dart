import 'package:flutter/material.dart';
import 'package:picture_show/features/criar_publicacao/criar_publicacao_provider.dart';
import 'package:picture_show/widgets/header/header.dart';
import 'package:picture_show/widgets/layout/app_scaffold.dart';
import 'package:picture_show/widgets/navigation/navigation_tab.dart';
import 'package:provider/provider.dart';

import 'widgets/camera_view.dart';
import 'widgets/confirmar_publicacao.dart';

class CriarPublicacao extends StatelessWidget {
  const CriarPublicacao({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CriarPublicacaoProvider>();
    final state = provider.state;

    final mostrandoCamera = state.imagem == null;

    return AppScaffold(
      currentTab: NavigationTab.create,
      appBar: mostrandoCamera
          ? null
          : const Header(
              title: 'Nova publicação',
            ),
      showNavigation: !mostrandoCamera,
      safeAreaTop: !mostrandoCamera,
      child: mostrandoCamera
          ? CameraView(
              onImagemSelecionada: provider.selecionarImagem,
            )
          : ConfirmarPublicacao(
              imagem: state.imagem!,
              onCancelar: provider.limpar,
            ),
    );
  }
}