import 'package:flutter/widgets.dart';

import 'bootstrap/bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final app = await Bootstrap.initialize();

  runApp(app);
}