import 'package:flutter/material.dart';
import 'package:picture_show/theme/app_colors.dart';
import 'package:picture_show/theme/app_spacing.dart';
import 'package:picture_show/theme/app_text_styles.dart';

class PublicacaoReacoes extends StatelessWidget {
  final int likes;
  final int dislikes;
  final int comentarios;

  const PublicacaoReacoes({
    super.key,
    required this.likes,
    required this.dislikes,
    required this.comentarios,
  });

  Widget _item(IconData icon, String texto) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          texto,
          style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _item(Icons.favorite_border, likes.toString()),

        const SizedBox(width: AppSpacing.lg),

        _item(Icons.thumb_down_alt_outlined, dislikes.toString()),

        const Spacer(),

        _item(Icons.mode_comment_outlined, comentarios.toString()),
      ],
    );
  }
}
