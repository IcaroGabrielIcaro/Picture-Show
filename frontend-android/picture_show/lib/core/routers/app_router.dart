import 'package:go_router/go_router.dart';
import 'package:picture_show/core/layouts/main_layout.dart';
import 'package:picture_show/features/auth/providers/auth_provider.dart';
import 'package:picture_show/features/buscar/pages/buscar_page.dart';
import 'package:picture_show/features/configuracoes/pages/configuracoes_page.dart';
import 'package:picture_show/features/feed/pages/feed_page.dart';
import 'package:picture_show/features/auth/pages/login_page.dart';
import 'package:picture_show/features/perfil/entities/profile.dart';
import 'package:picture_show/features/perfil/models/profile_posts.dart';
import 'package:picture_show/features/perfil/pages/perfil_page.dart';
import 'package:picture_show/features/perfil/pages/perfil_posts_page.dart';

// Instalando o GoRouter pelo comando 'flutter pub add go_router'

// appRouter vai ser o objeto responsável por toda a navegação
GoRouter createRouter(AuthProvider authProvider) {
  return GoRouter(
    initialLocation: '/login',

    refreshListenable: authProvider,

    redirect: (context, state) {
      final isAuthenticated = authProvider.isAuthenticated;
      final isLoginRoute = state.matchedLocation == '/login';

      if (!isAuthenticated && !isLoginRoute) {
        return '/login';
      }

      if (isAuthenticated && isLoginRoute) {
        return '/feed';
      }

      return null;
    },

    routes: [
      GoRoute(
        path: '/feed',
        name: 'feed',

        builder: (context, state) => const MainLayout(child: FeedPage()),
      ),

      GoRoute(
        path: '/perfil',
        name: 'perfil',

        builder: (context, state) {
          final profile = state.extra as Profile;

          return MainLayout(child: PerfilPage(profile: profile));
        },

        routes: [
          GoRoute(
            path: '/posts',
            name: 'perfil-posts',

            builder: (context, state) {
              final args = state.extra as PerfilPostsArgs;

              return MainLayout(
                child: PerfilPostsPage(
                  profile: args.profile,
                  initialIndex: args.initialIndex,
                ),
              );
            },
          ),
        ],
      ),

      GoRoute(
        path: '/buscar',
        name: 'buscar',

        builder: (context, state) => const MainLayout(child: BuscarPage()),
      ),

      GoRoute(
        path: '/configuracoes',
        name: 'configuracoes',
        builder: (context, state) {
          return const ConfiguracoesPage();
        },
      ),

      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
    ]
  );
}