import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../core/unions/failure.dart';
import '../core/usecase/base_uc.dart';
import '../model/register_user.dart';

@lazySingleton
class ValidateRegisterUserFormUc extends BaseUC<bool, RegisterUser> {
  ValidateRegisterUserFormUc();
  @override
  Either<Failure, bool> execute(RegisterUser param) {
    final isValidated = param.email.isNotEmpty &&
        param.name.isNotEmpty &&
        param.password.isNotEmpty &&
        param.phone.isNotEmpty &&
        param.roleId != 0;
    return right(isValidated);
  }
}
