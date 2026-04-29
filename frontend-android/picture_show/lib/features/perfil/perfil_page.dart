import 'package:flutter/material.dart';
import 'widgets/perfil_header.dart';
import 'widgets/perfil_info_section.dart';
import 'widgets/perfil_posts_grid.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            PerfilHeader(),
            Divider(),

            PerfilInfoSection(),

            Divider(),

            Expanded(
              child: PerfilPostsGrid(),
            ),
          ],
        ),
      ),
    );
  }
}