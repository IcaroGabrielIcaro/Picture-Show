import 'package:flutter/material.dart';
import 'widgets/perfil_header.dart';
import 'widgets/perfil_info_section.dart';
import 'widgets/perfil_posts_grid.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFFFFEEF),

      body: SafeArea(

        child: SingleChildScrollView(

          child: Padding(

            padding: const EdgeInsets.all(16),

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: const [
                PerfilHeader(),

                SizedBox(height: 12),

                Divider(
                  color: Color(0xFF3C3535),
                  thickness: 1,
                ),

                SizedBox(height: 12),

                PerfilInfoSection(),

                SizedBox(height: 12),

                Divider(
                  color: Color(0xFFD0D0D0),
                  thickness: 1,
                ),

                SizedBox(height: 12),

                PerfilPostsGrid(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}