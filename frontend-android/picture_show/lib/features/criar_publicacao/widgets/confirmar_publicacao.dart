import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:picture_show/features/criar_publicacao/criar_publicacao_provider.dart';
import 'package:picture_show/features/criar_publicacao/criar_publicacao_state.dart';
import 'package:picture_show/widgets/buttons/custom_button.dart';
import 'package:picture_show/widgets/inputs/custom_input.dart';
import 'package:provider/provider.dart';
import 'package:picture_show/theme/app_spacing.dart';

class ConfirmarPublicacao extends StatefulWidget {
  final File imagem;
  final VoidCallback onCancelar;

  const ConfirmarPublicacao({
    super.key,
    required this.imagem,
    required this.onCancelar,
  });

  @override
  State<ConfirmarPublicacao> createState() => _ConfirmarPublicacaoState();
}

class _ConfirmarPublicacaoState extends State<ConfirmarPublicacao> {
  final _formKey = GlobalKey<FormState>();

  final descricaoController = TextEditingController();

  @override
  void dispose() {
    descricaoController.dispose();
    super.dispose();
  }

  Future<void> _publicar() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final provider = context.read<CriarPublicacaoProvider>();

    provider.alterarDescricao(descricaoController.text.trim());

    await provider.publicar();

    if (!mounted) return;

    switch (provider.state.status) {
      case CriarPublicacaoStatus.success:
        context.goNamed('feed');
        break;

      case CriarPublicacaoStatus.error:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              provider.state.message ?? 'Não foi possível criar a publicação.',
            ),
          ),
        );
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CriarPublicacaoProvider>();

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.sm),
              child: Image.file(
                widget.imagem,
                height: 240,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            CustomInput(
              controller: descricaoController,
              label: 'Descrição',
              hintText: 'Escreva uma descrição para a publicação',
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              validator: (value) {
                return null;
              },
            ),

            const SizedBox(height: AppSpacing.xl),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: provider.state.loading
                        ? null
                        : widget.onCancelar,
                    child: const Text('Trocar imagem'),
                  ),
                ),

                const SizedBox(width: AppSpacing.md),

                Expanded(
                  child: CustomButton(
                    text: 'Publicar',
                    loading: provider.state.loading,
                    onPressed: _publicar,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
