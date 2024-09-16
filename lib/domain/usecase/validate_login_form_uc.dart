import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../core/unions/failure.dart';
import '../core/usecase/base_uc.dart';

class ValidateLoginFormUcParam {
  final String email;
  final String password;

  ValidateLoginFormUcParam({required this.email, required this.password});
}

@lazySingleton
class ValidateLoginFormUc extends BaseUC<bool, ValidateLoginFormUcParam> {
  ValidateLoginFormUc();
  @override
  Either<Failure, bool> execute(ValidateLoginFormUcParam param) {
    final isValidated = param.email.isNotEmpty && param.password.isNotEmpty;
    return right(isValidated);
  }
}
