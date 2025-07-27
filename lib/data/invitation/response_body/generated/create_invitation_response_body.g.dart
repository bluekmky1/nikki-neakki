// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../create_invitation_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateInvitationResponseBody _$CreateInvitationResponseBodyFromJson(
        Map<String, dynamic> json) =>
    CreateInvitationResponseBody(
      inviteCode: json['invite_code'] as String,
      expiresAt: DateTime.parse(json['expires_at'] as String),
      isNew: json['is_new'] as bool,
    );

Map<String, dynamic> _$CreateInvitationResponseBodyToJson(
        CreateInvitationResponseBody instance) =>
    <String, dynamic>{
      'invite_code': instance.inviteCode,
      'expires_at': instance.expiresAt.toIso8601String(),
      'is_new': instance.isNew,
    };
