import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'di/injection_container.dart';
import 'main_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(environment: dev);
  runApp(const MainApp());
}
