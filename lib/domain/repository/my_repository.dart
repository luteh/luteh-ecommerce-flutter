import 'package:fpdart/fpdart.dart';

import '../core/unions/failure.dart';

abstract class MyRepository {
  Future<Either<Failure, void>> saveLanguageCode(String languageCode);

  Either<Failure, String> getLanguageCode();
}
