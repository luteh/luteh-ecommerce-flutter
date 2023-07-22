import 'package:injectable/injectable.dart';

import 'di/injection_container.dart';

@lazySingleton
class AppConfig {
  final Environment env;

  AppConfig({required this.env});

  String get appName {
    const name = 'My App';
    switch (env) {
      case stg:
        return '$name stg';
      case dev:
        return '$name dev';
      default:
        return name;
    }
  }
}
