import 'package:flutter/material.dart';
import 'package:picture_show/theme/app_colors.dart';
import 'package:picture_show/theme/app_text_styles.dart';

class PublicacaoDescricao extends StatelessWidget {
  final String descricao;

  const PublicacaoDescricao({super.key, required this.descricao});

  @override
  Widget build(BuildContext context) {
    if (descricao.isEmpty) {
      return const SizedBox();
    }

    return Text(
      descricao,
      style: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
    );
  }
}
