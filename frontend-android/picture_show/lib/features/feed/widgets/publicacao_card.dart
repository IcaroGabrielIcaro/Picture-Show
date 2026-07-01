import 'package:flutter/material.dart';
import 'package:picture_show/features/feed/widgets/publicacao_descricao.dart';
import 'package:picture_show/features/feed/widgets/publicacao_header.dart';
import 'package:picture_show/features/feed/widgets/publicacao_imagem.dart';
import 'package:picture_show/features/feed/widgets/publicacao_reacoes.dart';
import 'package:picture_show/theme/app_colors.dart';
import 'package:picture_show/theme/app_radius.dart';
import 'package:picture_show/theme/app_spacing.dart';

class PublicacaoCard extends StatelessWidget {
  final Publicacao publicacao;

  const PublicacaoCard({super.key, required this.publicacao});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PublicacaoHeader(publicacao: publicacao),

            const SizedBox(height: AppSpacing.md),

            PublicacaoImagem(imagem: publicacao.imagem),

            const SizedBox(height: AppSpacing.md),

            PublicacaoDescricao(descricao: publicacao.descricao),

            const SizedBox(height: AppSpacing.md),

            PublicacaoReacoes(
              likes: publicacao.likes,
              dislikes: publicacao.dislikes,
              comentarios: publicacao.comentarios,
            ),
          ],
        ),
      ),
    );
  }
}
