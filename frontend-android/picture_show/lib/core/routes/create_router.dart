import 'package:go_router/go_router.dart';
import 'package:picture_show/features/autenticacao/autenticacao.dart';
import 'package:picture_show/features/autenticacao/autenticacao_provider.dart';

GoRouter createRouter(AutenticacaoProvider authProvider) {
  return GoRouter(
    initialLocation: '/login',

    refreshListenable: authProvider,

    redirect: (context, state) {
      final isAuthenticated = authProvider.usuario != null;

      final isLogin = state.matchedLocation == '/login';
      final isCadastro = state.matchedLocation == '/cadastro';

      // Se NÃO está logado, só pode acessar login ou cadastro
      if (!isAuthenticated) {
        if (isLogin || isCadastro) {
          return null;
        }
        return '/login';
      }

      // Se está logado, impede acessar login/cadastro
      if (isLogin || isCadastro) {
        return '/login'; // depois você troca para '/feed'
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
    ],
  );
}
