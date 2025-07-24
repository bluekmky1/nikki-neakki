import 'package:equatable/equatable.dart';

class SupabaseState extends Equatable {
  final bool isSignedIn;
  final String userId;
  final String username;

  const SupabaseState({
    required this.isSignedIn,
    required this.userId,
    required this.username,
  });

  const SupabaseState.init()
      : isSignedIn = false,
        userId = '',
        username = '';

  SupabaseState copyWith({
    bool? isSignedIn,
    String? userId,
    String? username,
  }) =>
      SupabaseState(
        isSignedIn: isSignedIn ?? this.isSignedIn,
        userId: userId ?? this.userId,
        username: username ?? this.username,
      );

  @override
  List<Object> get props => <Object>[
        isSignedIn,
        userId,
        username,
      ];
}
