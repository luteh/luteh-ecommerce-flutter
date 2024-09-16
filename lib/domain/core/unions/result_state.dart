import 'package:freezed_annotation/freezed_annotation.dart';

import 'failure.dart';

part 'result_state.freezed.dart';

@freezed
class ResultState<T> with _$ResultState<T> {
  const ResultState._();
  const factory ResultState.initial() = Initial<T>;

  const factory ResultState.loading() = Loading<T>;

  const factory ResultState.success({required T data}) = Success<T>;

  const factory ResultState.failure({required Failure failure}) = Error<T>;

  T? getOrNull() {
    if (this is Success) {
      return (this as Success).data;
    } else {
      return null;
    }
  }

  bool get isLoading => this is Loading;

  bool get isFailure => this is Error;

  bool get isSuccess => this is Success;
}
