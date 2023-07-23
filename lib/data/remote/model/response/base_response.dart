import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response.freezed.dart';
part 'base_response.g.dart';

@freezed
@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> with _$BaseResponse<T> {
  const factory BaseResponse({
    bool? success,
    String? message,
    String? token,
    String? refresh,
    T? data,
  }) = _BaseResponse;

  factory BaseResponse.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return _$BaseResponseFromJson<T>(json, fromJsonT);
  }
}
