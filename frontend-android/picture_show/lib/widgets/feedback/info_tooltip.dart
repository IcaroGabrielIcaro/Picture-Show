import 'package:flutter/material.dart';
import 'package:picture_show/theme/app_colors.dart';
import 'package:picture_show/theme/app_radius.dart';
import 'package:picture_show/theme/app_text_styles.dart';

/// Ícone de ajuda utilizado para fornecer informações adicionais
/// sobre campos da interface.
///
/// O texto é exibido ao passar o mouse (Desktop/Web)
/// ou ao manter pressionado (Android/iOS).
class InfoTooltip extends StatelessWidget {
  /// Texto apresentado ao usuário.
  final String message;

  /// Tamanho do ícone.
  final double size;

  const InfoTooltip({
    super.key,
    required this.message,
    this.size = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,

      preferBelow: false,

      waitDuration: const Duration(milliseconds: 300),

      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),

        border: Border.all(
          color: AppColors.border,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      textStyle: AppTextStyles.body.copyWith(
        color: AppColors.textPrimary,
      ),

      child: Icon(
        Icons.info_outline_rounded,
        size: size,
        color: AppColors.textSecondary,
      ),
    );
  }
}