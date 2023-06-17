// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserInfoPayload _$$_UserInfoPayloadFromJson(Map<String, dynamic> json) =>
    _$_UserInfoPayload(
      userId: json['userId'] as String,
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$$_UserInfoPayloadToJson(_$_UserInfoPayload instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'displayName': instance.displayName,
      'email': instance.email,
    };
