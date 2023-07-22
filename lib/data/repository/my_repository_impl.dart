import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/unions/failure.dart';
import '../../domain/model/login/login_entity.dart';
import '../../domain/repository/my_repository.dart';
import '../local/data_source/local_data_source.dart';
import '../remote/data_source/remote_data_source.dart';
import '../remote/model/request/login/login_request.dart';

@LazySingleton(as: MyRepository)
class MyRepositoryImpl implements MyRepository {
  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;

  MyRepositoryImpl(this._localDataSource, this._remoteDataSource);
  @override
  Either<Failure, String> getLanguageCode() {
    return right(_localDataSource.getLanguageCode());
  }

  @override
  Future<Either<Failure, void>> saveLanguageCode(String languageCode) async {
    return right(await _localDataSource.saveLanguageCode(languageCode));
  }

  @override
  Future<Either<Failure, LoginEntity>> login(
      {required String username, required String password}) async {
    final request = LoginRequest(userId: username, userPassword: password);
    final body = await _remoteDataSource.login(request);
    if (body.data == null) {
      return left(Failure.defaultError(error: body.message));
    } else {
      await _localDataSource.saveAccessToken(body.token ?? '');
      return right(body.data!.toEntity());
    }
  }

  @override
  Either<Failure, String> getAccessToken() {
    return right(_localDataSource.getAccessToken());
  }
}
