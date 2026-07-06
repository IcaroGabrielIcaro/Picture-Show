import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:picture_show/core/network/autenticacao_interceptor.dart';
import 'package:picture_show/core/storage/secure_storage_service.dart';

class DioClient {
  DioClient._();

  static Dio create(SecureStorageService storage) {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://192.168.0.166/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    final adapter = dio.httpClientAdapter as IOHttpClientAdapter;

    adapter.createHttpClient = () {
      final client = HttpClient();

      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
            return host == '192.168.0.166';
          };

      return client;
    };

    dio.interceptors.add(AuthInterceptor(dio: dio, storage: storage));

    return dio;
  }
}
