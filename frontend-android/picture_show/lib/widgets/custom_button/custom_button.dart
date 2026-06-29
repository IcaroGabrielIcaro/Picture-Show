import 'package:flutter/material.dart';
import 'package:picture_show/theme/app_colors.dart';
import 'package:picture_show/theme/app_radius.dart';
import 'package:picture_show/theme/app_text_styles.dart';
import 'package:picture_show/widgets/custom_button/custom_button_state.dart';

/// Botão padrão utilizado em todo o aplicativo.
///
/// Possui suporte para:
/// - botão primário;
/// - botão secundário;
/// - estado de carregamento;
/// - largura total.
///
/// Sempre utilize este widget ao invés de um `ElevatedButton`
/// diretamente para manter a identidade visual da aplicação.
class CustomButton extends StatelessWidget {
  /// Texto exibido no botão.
  final String text;

  /// Ação executada ao pressionar o botão.
  final VoidCallback? onPressed;

  /// Variante visual do botão.
  final CustomButtonVariant variant;

  /// Altura do botão.
  final double height;

  /// Exibe um indicador de carregamento.
  final bool loading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = CustomButtonVariant.primary,
    this.height = 48,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isPrimary = variant == CustomButtonVariant.primary;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,

        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,

          backgroundColor: isPrimary ? AppColors.primary : AppColors.surface,

          foregroundColor: isPrimary ? Colors.white : AppColors.textPrimary,

          disabledBackgroundColor: AppColors.border,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),

            side: isPrimary
                ? BorderSide.none
                : BorderSide(color: AppColors.border),
          ),
        ),

        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),

          child: loading
              ? const SizedBox(
                  key: ValueKey('loading'),
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(
                  text,
                  key: const ValueKey('text'),
                  style: AppTextStyles.button.copyWith(
                    color: isPrimary ? Colors.white : AppColors.textPrimary,
                  ),
                ),
        ),
      ),
    );
  }
}
