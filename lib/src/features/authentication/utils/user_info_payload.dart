import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nike_shoe_shop/src/features/core/domain/user_id.dart';

part 'user_info_payload.freezed.dart';
part "user_info_payload.g.dart";

@freezed
class UserInfoPayload with _$UserInfoPayload {
  const factory UserInfoPayload({
    required UserId userId,
    required String? displayName,
    required String? email,
  String ? photoUrl,
  }) = _UserInfoPayload;

  factory UserInfoPayload.fromJson(Map<String, dynamic> json) =>
      _$UserInfoPayloadFromJson(json);
}
