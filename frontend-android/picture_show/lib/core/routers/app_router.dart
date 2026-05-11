import 'package:go_router/go_router.dart';
import 'package:picture_show/core/layouts/main_layout.dart';
import 'package:picture_show/features/buscar/buscar_page.dart';
import 'package:picture_show/features/feed/feed_page.dart';
import 'package:picture_show/features/perfil/perfil_page.dart';

// Instalando o GoRouter pelo comando 'flutter pub add go_router'

// appRouter vai ser o objeto responsável por toda a navegação
final GoRouter appRouter = GoRouter(

  initialLocation: '/feed',

  routes: [

    GoRoute(
      path: '/feed',

      builder: (context, state) => const MainLayout(
        child: FeedPage(),
      ),
    ),

    GoRoute(
      path: '/perfil',

      builder: (context, state) => const MainLayout(
        child: PerfilPage(),
      ),
    ),

    GoRoute(
      path: '/buscar',

      builder: (context, state) => const MainLayout(
        child: BuscarPage(),
      ),
    ),

  ],
);