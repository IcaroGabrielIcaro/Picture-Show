import 'package:picture_show/core/network/dio_client.dart';
import 'package:picture_show/core/storage/secure_storage_service.dart';
import 'package:picture_show/features/autenticacao/autenticacao_provider.dart';
import 'package:picture_show/features/autenticacao/autenticacao_service.dart';
import 'package:picture_show/features/feed/feed_provider.dart';
import 'package:picture_show/features/feed/feed_repository.dart';
import 'package:picture_show/features/feed/feed_service.dart';
import 'package:picture_show/providers/usuario_provider.dart';
import 'package:picture_show/repositories/usuario_repository.dart';
import 'package:picture_show/services/usuario_local_service.dart';

class Dependencies {
  Dependencies._();

  late final SecureStorageService secureStorage;

  late final UsuarioLocalService usuarioLocalService;

  late final AutenticacaoService authService;
  late final FeedService feedService;

  late final UsuarioRepository usuarioRepository;
  late final FeedRepository feedRepository;

  late final UsuarioProvider usuarioProvider;
  late final AutenticacaoProvider authProvider;
  late final FeedProvider feedProvider;

  static Future<Dependencies> create() async {
    final d = Dependencies._();

    // Storage
    d.secureStorage = SecureStorageService();

    // Local
    d.usuarioLocalService = UsuarioLocalService();

    // Dio
    final dio = DioClient.create(d.secureStorage);

    // Services
    d.authService = AutenticacaoService(dio);
    d.feedService = FeedService(dio);

    // Repositories
    d.usuarioRepository = UsuarioRepository(
      api: d.authService,
      local: d.usuarioLocalService,
    );

    d.feedRepository = FeedRepository(api: d.feedService);

    // Providers
    d.usuarioProvider = UsuarioProvider(d.usuarioRepository);

    d.authProvider = AutenticacaoProvider(
      d.authService,
      d.secureStorage,
      d.usuarioRepository,
    );

    d.feedProvider = FeedProvider(d.feedRepository);

    return d;
  }
}
