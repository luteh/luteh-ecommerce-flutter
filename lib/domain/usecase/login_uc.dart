import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../core/extention/string_extention.dart';
import '../core/unions/failure.dart';
import '../core/usecase/base_uc.dart';
import '../model/login/login_entity.dart';
import '../repository/my_repository.dart';

class LoginUCParam {
  final String username;
  final String password;

  LoginUCParam({required this.username, required this.password});
}

@lazySingleton
class LoginUC extends BaseUCFuture<LoginEntity, LoginUCParam> {
  final MyRepository _myRepository;

  LoginUC(this._myRepository);
  @override
  Future<Either<Failure, LoginEntity>> execute(LoginUCParam param) {
    final hashedPassword = param.password.toSHA256();
    return _myRepository.login(
      username: param.username,
      password: hashedPassword,
    );
  }
}
