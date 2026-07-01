import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:picture_show/features/autenticacao/autenticacao_provider.dart';
import 'package:picture_show/features/autenticacao/autenticacao_state.dart';
import 'package:picture_show/providers/usuario_provider.dart';
import 'package:picture_show/widgets/buttons/custom_button.dart';
import 'package:picture_show/widgets/inputs/custom_input.dart';
import 'package:picture_show/theme/app_spacing.dart';
import 'package:provider/provider.dart';

/// Formulário responsável pela autenticação do usuário.
///
/// Este widget encapsula:
/// - gerenciamento dos controllers;
/// - validação dos campos;
/// - integração com o [AutenticacaoProvider];
/// - envio do formulário.
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final provider = context.read<AutenticacaoProvider>();
    final usuarioProvider = context.read<UsuarioProvider>();

    final response = await provider.login(
      username: usernameController.text.trim(),
      password: passwordController.text,
    );

    if (response != null) {
      usuarioProvider.definirUsuario(response.usuario);
    }

    if (!mounted) return;

    switch (provider.state.status) {
      case AutenticacaoStatus.success:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login realizado com sucesso!')),
        );

        // TODO:
        // Navegar para a tela principal.
        break;

      case AutenticacaoStatus.error:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              provider.state.message ?? 'Não foi possível realizar o login.',
            ),
          ),
        );
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AutenticacaoProvider>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomInput(
            controller: usernameController,
            label: 'Nome de usuário',
            hintText: 'Digite seu nome de usuário',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Informe seu nome de usuário.';
              }

              return null;
            },
          ),

          const SizedBox(height: AppSpacing.md),

          CustomInput(
            controller: passwordController,
            label: 'Senha',
            hintText: 'Digite sua senha',
            isPassword: true,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _login(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Informe sua senha.';
              }

              return null;
            },
          ),

          const SizedBox(height: AppSpacing.xs),

          TextButton(
            onPressed: () {
              context.go('/cadastro');
            },
            child: const Text('Crie sua conta'),
          ),

          const SizedBox(height: AppSpacing.xs),

          CustomButton(
            text: 'Entrar',
            loading: provider.state.status == AutenticacaoStatus.loading,
            onPressed: _login,
          ),
        ],
      ),
    );
  }
}
