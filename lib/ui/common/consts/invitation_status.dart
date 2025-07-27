enum InvitationStatus {
  pending,
  accepted,
  rejected,
  expired,
  none;

  factory InvitationStatus.fromString(String status) => switch (status) {
        'pending' => InvitationStatus.pending,
        'accepted' => InvitationStatus.accepted,
        'rejected' => InvitationStatus.rejected,
        'expired' => InvitationStatus.expired,
        'none' => InvitationStatus.none,
        _ => throw ArgumentError('Invalid invitation status: $status'),
      };

  String get value => name;
}
