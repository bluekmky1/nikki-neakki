// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../invitation_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvitationEntity _$InvitationEntityFromJson(Map<String, dynamic> json) =>
    InvitationEntity(
      id: json['id'] as String,
      inviteCode: json['invite_code'] as String,
      inviterId: json['inviter_id'] as String,
      inviteStatus: json['invite_status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      expireAt: DateTime.parse(json['expire_at'] as String),
      receiverId: json['receiver_id'] as String?,
      acceptedAt: json['accepted_at'] == null
          ? null
          : DateTime.parse(json['accepted_at'] as String),
    );

Map<String, dynamic> _$InvitationEntityToJson(InvitationEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invite_code': instance.inviteCode,
      'inviter_id': instance.inviterId,
      'receiver_id': instance.receiverId,
      'invite_status': instance.inviteStatus,
      'created_at': instance.createdAt.toIso8601String(),
      'expire_at': instance.expireAt.toIso8601String(),
      'accepted_at': instance.acceptedAt?.toIso8601String(),
    };
