import 'dart:developer';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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
      return await _executeOnIsolate(execute: () => execute(param));
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
      return await _executeOnIsolate(execute: () => execute());
    } catch (e) {
      _logException(e);
      return Left(Failure.getException(e));
    }
  }

  Future<Either<Failure, Result>> execute();
}

Future<Either<Failure, Result>> _executeOnIsolate<Result>(
    {required Future<Either<Failure, Result>> Function() execute}) async {
  RootIsolateToken? rootIsolateToken = RootIsolateToken.instance;
  if (rootIsolateToken == null) {
    throw Exception('Cannot get the RootIsolateToken');
  }

  final receivePort = ReceivePort();
  // Spawn the isolate
  await Isolate.spawn(
      (message) => _isolateFunction<Result>(message, execute: execute),
      [rootIsolateToken, receivePort.sendPort]);

  // Receive the value from the isolate
  final result = await receivePort.first as Either<Failure, Result>;
  return result;
}

Future<void> _isolateFunction<Result>(
  List<Object> message, {
  required Future<Either<Failure, Result>> Function() execute,
}) async {
  final rootIsolateToken = message[0] as RootIsolateToken;
  final sendPort = message[1] as SendPort;

  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

  late Either<Failure, Result> result;
  // Perform some computation
  try {
    result = await execute();
  } catch (e) {
    _logException(e);
    result = left(Failure.getException(e));
  }

  // Send the result back to the main isolate
  sendPort.send(result);
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
