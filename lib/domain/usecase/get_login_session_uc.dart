import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../core/unions/failure.dart';
import '../core/usecase/base_uc.dart';
import '../repository/my_repository.dart';

@lazySingleton
class GetLoginSessionUC extends BaseUCFutureWithoutParam<bool> {
  final MyRepository _myRepository;

  GetLoginSessionUC(this._myRepository);
  @override
  Future<Either<Failure, bool>> execute() async {
    await Future.delayed(const Duration(seconds: 2));
    return right(false);
  }
}
