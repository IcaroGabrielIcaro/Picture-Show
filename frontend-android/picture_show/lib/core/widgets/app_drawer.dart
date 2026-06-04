import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {

  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    return Drawer(

      backgroundColor: const Color(0xFFFFFEEF),

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
      ),

      child: ListView(

        padding: EdgeInsets.zero,

        children: [

          const DrawerHeader(

            decoration: BoxDecoration(
              color: Color(0xFFFFFEEF),
            ),

            child: Align(

              alignment: Alignment.bottomLeft,

              child: Text(
                'Picture Show',

                style: TextStyle(
                  fontFamily: 'JosefinSlab',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3C3535),
                ),
              ),

            ),

          ),

          ListTile(

            leading: const Icon(
              Icons.settings,
              color: Color(0xFF3C3535),
            ),

            title: const Text(
              'Configurações',

              style: TextStyle(
                fontFamily: 'JosefinSlab',
                fontSize: 18,
                color: Color(0xFF3C3535),
              ),
            ),

            onTap: () {
              context.pushNamed('configuracoes');
            },

          ),

          ListTile(

            leading: const Icon(
              Icons.info_outline,
              color: Color(0xFF3C3535),
            ),

            title: const Text(
              'Sobre',

              style: TextStyle(
                fontFamily: 'JosefinSlab',
                fontSize: 18,
                color: Color(0xFF3C3535),
              ),
            ),

            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Picture Show',
                applicationVersion: '1.0.0',
              );
            },

          ),

          ListTile(

            leading: const Icon(
              Icons.logout,
              color: Color(0xFF3C3535),
            ),

            title: const Text(
              'Logout',

              style: TextStyle(
                fontFamily: 'JosefinSlab',
                fontSize: 18,
                color: Color(0xFF3C3535),
              ),
            ),

            onTap: () {
              context.goNamed('login');
            },

          ),

        ],

      ),

    );

  }

}