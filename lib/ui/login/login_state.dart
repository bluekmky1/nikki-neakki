import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';

class LoginState extends Equatable {
  final LoadingStatus loadingStatus;
  final String example;
  final int selectedTabIndex;

  const LoginState({
    required this.loadingStatus,
    required this.example,
    required this.selectedTabIndex,
  });

  const LoginState.init()
      : loadingStatus = LoadingStatus.none,
        example = '',
        selectedTabIndex = 0;

  LoginState copyWith({
    LoadingStatus? loadingStatus,
    String? example,
    int? selectedTabIndex,
  }) =>
      LoginState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        example: example ?? this.example,
        selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      );

  @override
  List<Object> get props => <Object>[
        loadingStatus,
        example,
        selectedTabIndex,
      ];
}
