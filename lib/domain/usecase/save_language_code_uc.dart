import '../core/unions/failure.dart';
import '../core/usecase/base_uc.dart';
import '../repository/my_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

class SaveLanguageCodeUCParam {
  final String languageCode;

  SaveLanguageCodeUCParam(this.languageCode);
}

@lazySingleton
class SaveLanguageCodeUC extends BaseUCFuture<void, SaveLanguageCodeUCParam> {
  final MyRepository _myRepository;

  SaveLanguageCodeUC(this._myRepository);
  @override
  Future<Either<Failure, void>> execute(SaveLanguageCodeUCParam param) {
    return _myRepository.saveLanguageCode(param.languageCode);
  }
}
