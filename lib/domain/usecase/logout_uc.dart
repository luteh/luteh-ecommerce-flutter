import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../core/unions/failure.dart';
import '../core/usecase/base_uc.dart';
import '../repository/my_repository.dart';

@lazySingleton
class LogoutUC extends BaseUCFutureWithoutParam<void> {
  final MyRepository _myRepository;

  LogoutUC(this._myRepository);
  @override
  Future<Either<Failure, void>> execute() {
    return _myRepository.logout();
  }
}
