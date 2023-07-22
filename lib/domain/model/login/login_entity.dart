import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_entity.freezed.dart';

@freezed
class LoginEntity with _$LoginEntity {
  const factory LoginEntity({
    required String userId,
    required String userName,
    required int levelId,
    required dynamic userMail,
    required String branchId,
    required String levelName,
    required dynamic userMenu,
    required int storeId,
    required String storeName,
    required String storeAddress,
    required String storePhone,
    required int flagStore,
    required dynamic storeTaxId,
    required dynamic pkpDate,
    required int isPkp,
    required dynamic ledgerDate,
    required int allowMinusTransaction,
    required dynamic lastAllowedDate,
    required int printSizeDefault,
    required String taxRatio,
    required dynamic validUntil,
  }) = _LoginEntity;
}
