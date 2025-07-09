import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';

class HomeState extends Equatable {
  final LoadingStatus loadingStatus;
  final String example;
  final int selectedTabIndex;

  const HomeState({
    required this.loadingStatus,
    required this.example,
    required this.selectedTabIndex,
  });

  const HomeState.init()
      : loadingStatus = LoadingStatus.none,
        example = '',
        selectedTabIndex = 0;

  HomeState copyWith({
    LoadingStatus? loadingStatus,
    String? example,
    int? selectedTabIndex,
  }) =>
      HomeState(
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
