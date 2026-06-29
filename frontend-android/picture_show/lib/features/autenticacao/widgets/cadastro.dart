import 'package:flutter/material.dart';
import 'package:picture_show/features/autenticacao/autenticacao_provider.dart';
import 'package:picture_show/widgets/custom_button/custom_button.dart';
import 'package:picture_show/widgets/custom_input/custom_input.dart';
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

    final provider = context.read<AutenticacaoProvider>();

    await provider.cadastro(
      username: usernameController.text.trim(),
      nome: nomeController.text.trim(),
      senha: senhaController.text,
    );

    if (!mounted) return;

    switch (provider.state.status) {
      case AutenticacaoStatus.success:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cadastro realizado com sucesso!')),
        );
        break;

      case AutenticacaoStatus.error:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              provider.state.message ?? 'Não foi possível realizar o cadastro.',
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
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Informe um nome de usuário.';
              }

              if (value.trim().length < 3) {
                return 'Mínimo de 3 caracteres.';
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

          const SizedBox(height: AppSpacing.lg),

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
