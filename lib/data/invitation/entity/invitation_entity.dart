import 'package:json_annotation/json_annotation.dart';

part 'generated/invitation_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class InvitationEntity {
  final String id;
  final String inviteCode;
  final String inviterId;
  final String? receiverId;
  final String inviteStatus;
  final DateTime createdAt;
  final DateTime expireAt;
  final DateTime? acceptedAt;

  const InvitationEntity({
    required this.id,
    required this.inviteCode,
    required this.inviterId,
    required this.inviteStatus,
    required this.createdAt,
    required this.expireAt,
    this.receiverId,
    this.acceptedAt,
  });

  factory InvitationEntity.fromJson(Map<String, dynamic> json) =>
      _$InvitationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$InvitationEntityToJson(this);

  factory InvitationEntity.empty() => InvitationEntity(
        id: '',
        inviteCode: '',
        inviterId: '',
        inviteStatus: 'none',
        createdAt: DateTime(1900),
        expireAt: DateTime(1900),
      );
}
