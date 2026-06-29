import 'package:flutter/material.dart';
import 'package:picture_show/theme/app_colors.dart';
import 'package:picture_show/theme/app_radius.dart';
import 'package:picture_show/theme/app_spacing.dart';
import 'package:picture_show/theme/app_text_styles.dart';

/// Campo de entrada padrão utilizado em todo o aplicativo.
///
/// Possui suporte para:
/// - texto simples;
/// - senha com botão para exibir/ocultar;
/// - validação;
/// - diferentes teclados;
/// - ações do teclado.
///
/// Sempre utilize este widget no lugar de um `TextFormField` diretamente,
/// para manter uma identidade visual consistente.
class CustomInput extends StatefulWidget {
  /// Texto exibido acima do campo.
  final String label;

  /// Texto de ajuda exibido dentro do campo.
  final String hintText;

  /// Controller responsável pelo valor do campo.
  final TextEditingController? controller;

  /// Define se o campo representa uma senha.
  final bool isPassword;

  /// Quantidade máxima de linhas.
  final int maxLines;

  /// Campo habilitado.
  final bool enabled;

  /// Tipo do teclado.
  final TextInputType keyboardType;

  /// Ação do teclado.
  final TextInputAction textInputAction;

  /// Validação do campo.
  final String? Function(String?)? validator;

  /// Callback ao finalizar edição.
  final void Function(String)? onFieldSubmitted;

  const CustomInput({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.isPassword = false,
    this.maxLines = 1,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.onFieldSubmitted,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTextStyles.label.copyWith(color: AppColors.textPrimary),
        ),

        const SizedBox(height: AppSpacing.xs),

        TextFormField(
          controller: widget.controller,
          enabled: widget.enabled,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          obscureText: widget.isPassword ? _obscureText : false,
          style: AppTextStyles.input,

          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: AppTextStyles.hint.copyWith(
              color: AppColors.textSecondary,
            ),

            filled: true,
            fillColor: AppColors.surface,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: 14,
            ),

            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(color: AppColors.border),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(color: AppColors.primary, width: 1.5),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(color: AppColors.error),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(color: AppColors.error, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
