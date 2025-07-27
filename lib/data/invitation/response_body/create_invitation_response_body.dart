import 'package:json_annotation/json_annotation.dart';

part 'generated/create_invitation_response_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CreateInvitationResponseBody {
  final String inviteCode;
  final DateTime expiresAt;
  final bool isNew;

  const CreateInvitationResponseBody({
    required this.inviteCode,
    required this.expiresAt,
    required this.isNew,
  });

  factory CreateInvitationResponseBody.fromJson(Map<String, dynamic> json) =>
      _$CreateInvitationResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CreateInvitationResponseBodyToJson(this);
}
