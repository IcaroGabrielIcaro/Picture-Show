import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  static const _trustedHosts = {'192.168.0.166', '10.0.2.2', 'localhost'};

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);

    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) {
          return _trustedHosts.contains(host);
        };

    return client;
  }
}
