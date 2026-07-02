import 'package:dio/dio.dart';
import 'package:picture_show/core/storage/secure_storage_service.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final SecureStorageService storage;

  bool _isRefreshing = false;

  AuthInterceptor({required this.dio, required this.storage});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await storage.obterAccessToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.requestOptions.path.endsWith('login/refresh/')) {
      await storage.limpar();
      return handler.next(err);
    }

    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    if (_isRefreshing) {
      return handler.next(err);
    }

    final refreshToken = await storage.obterRefreshToken();

    if (refreshToken == null) {
      await storage.limpar();
      return handler.next(err);
    }

    _isRefreshing = true;

    try {
      final response = await dio.post(
        'login/refresh/',
        data: {'refresh': refreshToken},
        options: Options(
          headers: {
            // evita enviar o access expirado
            'Authorization': null,
          },
        ),
      );

      final novoAccessToken = response.data['access'] as String;

      await storage.salvarAccessToken(novoAccessToken);

      final request = err.requestOptions;

      request.headers['Authorization'] = 'Bearer $novoAccessToken';

      final novaResposta = await dio.fetch(request);

      handler.resolve(novaResposta);
    } catch (_) {
      await storage.limpar();

      handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }
}
