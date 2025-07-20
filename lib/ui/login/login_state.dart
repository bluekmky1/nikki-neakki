import 'package:equatable/equatable.dart';
import '../../core/loading_status.dart';

class LoginState extends Equatable {
  final LoadingStatus kakaoOauthLoadingStatus;
  final bool needOnboarding;

  const LoginState({
    required this.kakaoOauthLoadingStatus,
    required this.needOnboarding,
  });

  const LoginState.init()
      : kakaoOauthLoadingStatus = LoadingStatus.none,
        needOnboarding = false;

  LoginState copyWith({
    LoadingStatus? kakaoOauthLoadingStatus,
    bool? needOnboarding,
  }) =>
      LoginState(
        kakaoOauthLoadingStatus:
            kakaoOauthLoadingStatus ?? this.kakaoOauthLoadingStatus,
        needOnboarding: needOnboarding ?? this.needOnboarding,
      );

  @override
  List<Object> get props => <Object>[
        kakaoOauthLoadingStatus,
        needOnboarding,
      ];
}
