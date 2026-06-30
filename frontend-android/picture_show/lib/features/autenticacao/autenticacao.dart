import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:picture_show/features/autenticacao/widgets/cadastro.dart';
import 'package:picture_show/features/autenticacao/widgets/login.dart';
import 'package:picture_show/theme/app_radius.dart';
import 'package:picture_show/theme/app_text_styles.dart';
import 'package:picture_show/theme/app_colors.dart';
import 'package:picture_show/theme/app_spacing.dart';

class Autenticacao extends StatelessWidget {
  const Autenticacao({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    final isLogin = location == '/login';

    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),

            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.photo_camera_outlined,
                    size: 56,
                    color: AppColors.primary,
                  ),

                  const SizedBox(height: AppSpacing.md),

                  Text('Picture Show', style: AppTextStyles.logo),

                  const SizedBox(height: AppSpacing.sm),

                  Text(
                    'Compartilhe seus melhores momentos.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.subtitle,
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),

                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      border: Border.all(color: AppColors.border),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),

                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: isLogin
                          ? const Login(key: ValueKey('login'))
                          : const Cadastro(key: ValueKey('cadastro')),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
