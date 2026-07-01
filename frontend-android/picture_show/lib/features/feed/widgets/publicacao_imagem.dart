import 'package:flutter/material.dart';
import 'package:picture_show/theme/app_colors.dart';
import 'package:picture_show/theme/app_radius.dart';

class PublicacaoImagem extends StatelessWidget {
  final String imagem;

  const PublicacaoImagem({super.key, required this.imagem});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.network(
          imagem,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            return Container(
              color: AppColors.border,
              child: const Icon(Icons.image_not_supported),
            );
          },
        ),
      ),
    );
  }
}
