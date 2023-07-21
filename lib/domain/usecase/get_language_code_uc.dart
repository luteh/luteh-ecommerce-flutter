import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../core/unions/failure.dart';
import '../core/usecase/base_uc.dart';
import '../repository/my_repository.dart';

@lazySingleton
class GetLanguageCodeUC extends BaseUCWithoutParam<String> {
  final MyRepository _myRepository;

  GetLanguageCodeUC(this._myRepository);
  @override
  Either<Failure, String> execute() {
    return _myRepository.getLanguageCode();
  }
}
