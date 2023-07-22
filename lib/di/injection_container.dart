import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection_container.config.dart';

const stg = Environment('stg');

final getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies({required Environment environment}) async =>
    await getIt.init(
      environment: environment.name,
    );
