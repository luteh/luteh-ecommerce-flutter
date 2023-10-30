import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

import '../unions/failure.dart';

abstract class BaseUC<Result, Param> {
  Either<Failure, Result> call(Param param) {
    try {
      return execute(param);
    } catch (e) {
      _logException(e);
      return Left(Failure.getException(e));
    }
  }

  Either<Failure, Result> execute(Param param);
}

abstract class BaseUCWithoutParam<Result> {
  Either<Failure, Result> call() {
    try {
      return execute();
    } catch (e) {
      _logException(e);
      return Left(Failure.getException(e));
    }
  }

  Either<Failure, Result> execute();
}

abstract class BaseUCFuture<Result, Param> {
  Future<Either<Failure, Result>> call(Param param) async {
    try {
      return execute(param);
    } catch (e) {
      _logException(e);
      return Left(Failure.getException(e));
    }
  }

  Future<Either<Failure, Result>> execute(Param param);
}

abstract class BaseUCFutureWithoutParam<Result> {
  Future<Either<Failure, Result>> call() async {
    try {
      return execute();
    } catch (e) {
      _logException(e);
      return Left(Failure.getException(e));
    }
  }

  Future<Either<Failure, Result>> execute();
}

void _logException(Object e) {
  if (kReleaseMode) return;

  if (e is TypeError) {
    log(
      e.toString(),
      stackTrace: e.stackTrace,
    );
  } else if (e is NoSuchMethodError) {
    log(e.toString(), stackTrace: e.stackTrace);
  } else {
    log(e.toString());
  }
}
