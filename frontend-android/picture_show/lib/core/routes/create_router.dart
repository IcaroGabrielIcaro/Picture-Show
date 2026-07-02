import 'package:go_router/go_router.dart';
import 'package:picture_show/features/autenticacao/autenticacao.dart';
import 'package:picture_show/features/feed/feed.dart';
import 'package:picture_show/providers/usuario_provider.dart';

GoRouter createRouter(UsuarioProvider usuarioProvider) {
  return GoRouter(
    initialLocation: '/login',

    refreshListenable: usuarioProvider,

    redirect: (context, state) {
      final isAuthenticated = usuarioProvider.isAuthenticated;

      final location = state.matchedLocation;

      final isLogin = location == '/login';
      final isCadastro = location == '/cadastro';

      // Usuário NÃO autenticado
      if (!isAuthenticated) {
        if (isLogin || isCadastro) {
          return null;
        }

        return '/login';
      }

      // Usuário autenticado
      if (isLogin || isCadastro) {
        return '/feed';
      }

      return null;
    },

    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const Autenticacao(),
      ),

      GoRoute(
        path: '/cadastro',
        name: 'cadastro',
        builder: (context, state) => const Autenticacao(),
      ),

      GoRoute(
        path: '/feed',
        name: 'feed',
        builder: (context, state) => const Feed(),
      ),
    ],
  );
}
