import 'dart:io';

import 'package:flutter/material.dart';
import 'package:picture_show/features/criar_publicacao/criar_publicacao_provider.dart';
import 'package:provider/provider.dart';

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
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CriarPublicacaoProvider>();

    return Column(
      children: [
        Expanded(
          child: Image.file(
            widget.imagem,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: TextField(
            controller: _controller,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Adicione uma descrição...',
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: provider.state.loading ? null : widget.onCancelar,
                  child: const Text('Cancelar'),
                ),
              ),

              const SizedBox(width: AppSpacing.md),

              Expanded(
                child: PrimaryButton(
                  loading: provider.state.loading,
                  text: 'Publicar',
                  onPressed: () async {
                    final sucesso = await provider.criarPublicacao(
                      imagem: widget.imagem,
                      descricao: _controller.text.trim(),
                    );

                    if (!context.mounted) return;

                    if (sucesso) {
                      Navigator.pop(context, true);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
