import 'package:fpdart/fpdart.dart';

import '../core/unions/failure.dart';
import '../model/login/login_entity.dart';

abstract class MyRepository {
  Future<Either<Failure, void>> saveLanguageCode(String languageCode);

  Either<Failure, String> getLanguageCode();

  Future<Either<Failure, LoginEntity>> login({
    required String username,
    required String password,
  });

  Either<Failure, String> getAccessToken();

  Future<Either<Failure, void>> logout();
}
