import 'package:flutter/material.dart';
import 'package:picture_show/features/feed/widgets/avatar_usuario.dart';
import 'package:picture_show/theme/app_colors.dart';
import 'package:picture_show/theme/app_text_styles.dart';
import 'package:picture_show/theme/app_spacing.dart';

class PublicacaoHeader extends StatelessWidget {
  final Publicacao publicacao;

  const PublicacaoHeader({super.key, required this.publicacao});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AvatarUsuario(imagem: publicacao.autor.imagem),

        const SizedBox(width: AppSpacing.sm),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                publicacao.autor.nome,
                style: AppTextStyles.label.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                "@${publicacao.autor.username}",
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),

        Text(
          publicacao.publicadoEmFormatado,
          style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
