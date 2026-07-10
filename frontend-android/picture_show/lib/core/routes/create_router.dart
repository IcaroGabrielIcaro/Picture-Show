import 'package:go_router/go_router.dart';
import 'package:picture_show/bootstrap/dependencies.dart';
import 'package:picture_show/features/autenticacao/autenticacao.dart';
import 'package:picture_show/features/autenticacao/autenticacao_provider.dart';
import 'package:picture_show/features/criar_publicacao/criar_publicacao.dart';
import 'package:picture_show/features/criar_publicacao/criar_publicacao_provider.dart';
import 'package:picture_show/features/feed/feed.dart';
import 'package:picture_show/features/feed/feed_provider.dart';
import 'package:provider/provider.dart';

GoRouter createRouter(Dependencies dependencies) {
  final usuarioProvider = dependencies.usuarioProvider;

  return GoRouter(
    initialLocation: '/login',

    refreshListenable: usuarioProvider,

    redirect: (context, state) {
      final isAuthenticated = usuarioProvider.isAuthenticated;

      final location = state.matchedLocation;

      final isLogin = location == '/login';
      final isCadastro = location == '/cadastro';

      if (!isAuthenticated) {
        if (isLogin || isCadastro) {
          return null;
        }

        return '/login';
      }

      if (isLogin || isCadastro) {
        return '/feed';
      }

      return null;
    },

    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (_) => AutenticacaoProvider(
              dependencies.authService,
              dependencies.secureStorage,
              dependencies.usuarioRepository,
            ),
            child: const Autenticacao(),
          );
        },
      ),

      GoRoute(
        path: '/cadastro',
        name: 'cadastro',
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (_) => AutenticacaoProvider(
              dependencies.authService,
              dependencies.secureStorage,
              dependencies.usuarioRepository,
            ),
            child: const Autenticacao(),
          );
        },
      ),

      GoRoute(
        path: '/feed',
        name: 'feed',
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (_) =>
                FeedProvider(dependencies.feedRepository)
                  ..carregarFeed(),
            child: const Feed(),
          );
        },
      ),

      GoRoute(
        path: '/criar-publicacao',
        name: 'criar-publicacao',
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (_) =>
                CriarPublicacaoProvider(dependencies.criarPublicacaoRepository),
            child: const CriarPublicacao(),
          );
        },
      ),
    ],
  );
}
