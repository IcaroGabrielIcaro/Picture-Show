import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:picture_show/core/exceptions/api_exception.dart';
import 'package:picture_show/features/autenticacao/autenticacao_provider.dart';
import 'package:picture_show/features/autenticacao/autenticacao_service.dart';
import 'package:picture_show/widgets/buttons/custom_button.dart';
import 'package:picture_show/widgets/inputs/custom_input.dart';
import 'package:picture_show/features/autenticacao/autenticacao_state.dart';
import 'package:picture_show/theme/app_spacing.dart';
import 'package:provider/provider.dart';

/// Formulário responsável pelo cadastro de usuários.
///
/// Este widget encapsula:
/// - gerenciamento dos controllers;
/// - validação dos campos;
/// - integração com o [AutenticacaoProvider];
/// - envio do formulário.
class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final nomeController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    nomeController.dispose();
    senhaController.dispose();
    confirmarController.dispose();
    super.dispose();
  }

  Future<void> _cadastrar() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final service = context.read<AutenticacaoService>();

    try {
      await service.cadastrar(
        username: usernameController.text.trim(),
        nome: nomeController.text.trim(),
        senha: senhaController.text,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro realizado com sucesso!')),
      );

      context.goNamed('login');
    } on ApiException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
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
            helpText:
                'Será utilizado para fazer login e identificar seu perfil. '
                'Não pode ser alterado facilmente e deve ser único.',
            keyboardType: TextInputType.text,
            validator: (value) {
              final username = value?.trim() ?? '';

              if (value == null || value.trim().isEmpty) {
                return 'Informe um nome de usuário.';
              }

              if (value.trim().length < 3) {
                return 'Mínimo de 3 caracteres.';
              }

              if (!RegExp(r'^[\w.@+-]+$').hasMatch(username)) {
                return 'Apenas letras, números e os caracteres @ . + - _.';
              }

              return null;
            },
          ),

          const SizedBox(height: AppSpacing.md),

          CustomInput(
            controller: nomeController,
            label: 'Nome',
            hintText: 'Digite seu nome',
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Informe seu nome.';
              }

              return null;
            },
          ),

          const SizedBox(height: AppSpacing.md),

          CustomInput(
            controller: senhaController,
            label: 'Senha',
            hintText: 'Digite sua senha',
            isPassword: true,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Informe uma senha.';
              }

              if (value.length < 6) {
                return 'A senha deve possuir pelo menos 6 caracteres.';
              }

              return null;
            },
          ),

          const SizedBox(height: AppSpacing.md),

          CustomInput(
            controller: confirmarController,
            label: 'Confirmar senha',
            hintText: 'Digite novamente sua senha',
            isPassword: true,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _cadastrar(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Confirme sua senha.';
              }

              if (value != senhaController.text) {
                return 'As senhas não coincidem.';
              }

              return null;
            },
          ),

          const SizedBox(height: AppSpacing.xs),

          TextButton(
            onPressed: () {
              context.go('/login');
            },
            child: const Text('Já possuo conta'),
          ),

          const SizedBox(height: AppSpacing.xs),

          CustomButton(
            text: 'Criar conta',
            loading: provider.state.status == AutenticacaoStatus.loading,
            onPressed: _cadastrar,
          ),
        ],
      ),
    );
  }
}
