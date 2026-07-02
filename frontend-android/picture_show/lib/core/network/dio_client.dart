import 'package:dio/dio.dart';
import 'package:picture_show/core/network/autenticacao_interceptor.dart';
import 'package:picture_show/core/storage/secure_storage_service.dart';

class DioClient {
  DioClient._();

  static Dio create(SecureStorageService storage) {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://localhost/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(AuthInterceptor(dio: dio, storage: storage));

    return dio;
  }
}
