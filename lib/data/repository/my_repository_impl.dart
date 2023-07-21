import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/unions/failure.dart';
import '../../domain/repository/my_repository.dart';
import '../local/data_source/local_data_source.dart';

@LazySingleton(as: MyRepository)
class MyRepositoryImpl implements MyRepository {
  final LocalDataSource _localDataSource;

  MyRepositoryImpl(this._localDataSource);
  @override
  Either<Failure, String> getLanguageCode() {
    return right(_localDataSource.getLanguageCode());
  }

  @override
  Future<Either<Failure, void>> saveLanguageCode(String languageCode) async {
    return right(await _localDataSource.saveLanguageCode(languageCode));
  }
}
