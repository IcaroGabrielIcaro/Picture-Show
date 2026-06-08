import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:picture_show/features/auth/providers/auth_provider.dart';
import 'package:picture_show/shared/theme/app_colors.dart';
import 'package:picture_show/shared/theme/app_text_styles.dart';
import 'package:picture_show/shared/widgets/buttons/custom_button.dart';
import 'package:picture_show/shared/widgets/inputs/custom_input.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text('Picture Show', style: AppTextStyles.logo),

                const SizedBox(height: 48),

                CustomInput(
                  controller: emailController,
                  label: 'Email',
                  hintText: 'Digite seu email',
                ),

                const SizedBox(height: 16),

                CustomInput(
                  controller: passwordController,
                  label: 'Senha',
                  hintText: 'Digite sua senha',
                  isPassword: true,
                ),

                const SizedBox(height: 24),

                CustomButton(
                  text: 'Entrar',
                  fontSize: 16,
                  onPressed: () async {
                    final authProvider = context.read<AuthProvider>();
                    final router = GoRouter.of(context);
                    final messenger = ScaffoldMessenger.of(context);

                    final success = await authProvider.login(
                      email: emailController.text.trim(), 
                      password: passwordController.text
                    );

                    if (!mounted) return;

                    if (success) {
                      router.goNamed('feed');
                    } else {
                      messenger.showSnackBar(
                        const SnackBar(content: Text("E-mail ou senha inválidos"))
                      );
                    }
                  },
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}