import 'package:equatable/equatable.dart';

class SupabaseState extends Equatable {
  final bool isSignedIn;

  const SupabaseState({
    required this.isSignedIn,
  });

  const SupabaseState.init() : isSignedIn = false;

  SupabaseState copyWith({
    bool? isSignedIn,
  }) =>
      SupabaseState(
        isSignedIn: isSignedIn ?? this.isSignedIn,
      );

  @override
  List<Object> get props => <Object>[
        isSignedIn,
      ];
}
