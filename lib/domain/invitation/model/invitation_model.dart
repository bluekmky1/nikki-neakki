import 'package:equatable/equatable.dart';

import '../../../ui/common/consts/invitation_status.dart';

class InvitationModel extends Equatable {
  final String inviteCode;
  final InvitationStatus status;
  final DateTime expireAt;

  const InvitationModel({
    required this.inviteCode,
    required this.status,
    required this.expireAt,
  });

  @override
  List<Object?> get props => <Object?>[
        inviteCode,
        status,
        expireAt,
      ];
}
