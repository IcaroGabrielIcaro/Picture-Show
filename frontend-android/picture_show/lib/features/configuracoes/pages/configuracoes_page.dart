import 'package:flutter/material.dart';
import 'package:picture_show/features/configuracoes/widgets/configuracao_item.dart';
import 'package:picture_show/shared/theme/app_colors.dart';
import 'package:picture_show/shared/widgets/headers/page_header.dart';

class ConfiguracoesPage extends StatelessWidget {

  const ConfiguracoesPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: AppColors.background,

      body: SafeArea(

        child: SingleChildScrollView(

          child: Padding(

            padding: const EdgeInsets.all(16),

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                const PageHeader(nome: 'Configurações'),
                const SizedBox(height: 12),
                const Divider(color: AppColors.primary, thickness: 1),
                const SizedBox(height: 12),
                const ConfiguracaoItem(icon: Icons.dark_mode_outlined, titulo: 'Modo Escuro'),
                const SizedBox(height: 8),
                const ConfiguracaoItem(icon: Icons.text_fields, titulo: 'Tamanho da Fonte'),
                const SizedBox(height: 8),
                const ConfiguracaoItem(icon: Icons.lock_outline, titulo: 'Privacidade'),
                const SizedBox(height: 8),
                const ConfiguracaoItem(icon: Icons.timer_outlined, titulo: 'Tempo de Tela'),
                const SizedBox(height: 8),
                const ConfiguracaoItem(icon: Icons.notifications_outlined, titulo: 'Notificações'),
                const SizedBox(height: 8),
                const ConfiguracaoItem(icon: Icons.language_outlined, titulo: 'Idioma'),

              ],

            ),

          ),

        ),

      ),

    );

  }

}