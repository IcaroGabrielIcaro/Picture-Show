import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavbar extends StatelessWidget {

  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {

    final String location = GoRouterState.of(context).uri.toString();

    int currentIndex = 0;

    if (location == '/feed') {
      currentIndex = 0;
    }

    if (location == '/buscar') {
      currentIndex = 1;
    }

    if (location == '/perfil') {
      currentIndex = 4;
    }

    return BottomNavigationBar(

      type: BottomNavigationBarType.fixed,

      currentIndex: currentIndex,

      selectedItemColor: const Color(0xFF3C3535),
      unselectedItemColor: Colors.grey,

      selectedLabelStyle: const TextStyle(
        fontFamily: 'JosefinSlab',
        fontSize: 14,
      ),

      unselectedLabelStyle: const TextStyle(
        fontFamily: 'JosefinSlab',
        fontSize: 14,
      ),

      onTap: (index) {

        if (index == 0) {
          context.go('/feed');
        }

        if (index == 1) {
          context.go('/buscar');
        }

        if (index == 4) {
          context.go('/perfil');
        }

      },

      items: [

        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Feed',
        ),

        const BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Buscar',
        ),

        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF3C3535),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          label: '',
        ),

        const BottomNavigationBarItem(
          icon: Icon(Icons.notifications_none),
          label: 'Notificações',
        ),

        const BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Perfil',
        ),

      ],
    );
  }
}