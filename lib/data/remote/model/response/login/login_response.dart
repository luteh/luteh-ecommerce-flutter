import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/model/login/login_entity.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

@freezed
class LoginResponse with _$LoginResponse {
  const LoginResponse._();
  const factory LoginResponse({
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'user_name') String? userName,
    @JsonKey(name: 'level_id') int? levelId,
    @JsonKey(name: 'user_mail') dynamic userMail,
    @JsonKey(name: 'branch_id') String? branchId,
    @JsonKey(name: 'level_name') String? levelName,
    @JsonKey(name: 'user_menu') dynamic userMenu,
    @JsonKey(name: 'store_id') int? storeId,
    @JsonKey(name: 'store_name') String? storeName,
    @JsonKey(name: 'store_address') String? storeAddress,
    @JsonKey(name: 'store_phone') String? storePhone,
    @JsonKey(name: 'flag_store') int? flagStore,
    @JsonKey(name: 'store_tax_id') dynamic storeTaxId,
    @JsonKey(name: 'pkp_date') dynamic pkpDate,
    @JsonKey(name: 'is_pkp') int? isPkp,
    @JsonKey(name: 'ledger_date') dynamic ledgerDate,
    @JsonKey(name: 'allow_minus_transaction') int? allowMinusTransaction,
    @JsonKey(name: 'last_allowed_date') dynamic lastAllowedDate,
    @JsonKey(name: 'print_size_default') int? printSizeDefault,
    @JsonKey(name: 'tax_ratio') String? taxRatio,
    @JsonKey(name: 'valid_until') dynamic validUntil,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  LoginEntity toEntity() => LoginEntity(
        userId: userId ?? '',
        userName: userName ?? '',
        levelId: levelId ?? 0,
        userMail: userMail ?? '',
        branchId: branchId ?? '',
        levelName: levelName ?? '',
        userMenu: userMenu ?? '',
        storeId: storeId ?? 0,
        storeName: storeName ?? '',
        storeAddress: storeAddress ?? '',
        storePhone: storePhone ?? '',
        flagStore: flagStore ?? 0,
        storeTaxId: storeTaxId ?? '',
        pkpDate: pkpDate ?? '',
        isPkp: isPkp ?? 0,
        ledgerDate: ledgerDate ?? '',
        allowMinusTransaction: allowMinusTransaction ?? 0,
        lastAllowedDate: lastAllowedDate ?? '',
        printSizeDefault: printSizeDefault ?? 0,
        taxRatio: taxRatio ?? '',
        validUntil: validUntil ?? '',
      );
}
