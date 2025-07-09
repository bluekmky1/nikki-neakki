import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';

class MyState extends Equatable {
  final LoadingStatus loadingStatus;
  final String example;
  final int selectedTabIndex;

  const MyState({
    required this.loadingStatus,
    required this.example,
    required this.selectedTabIndex,
  });

  const MyState.init()
      : loadingStatus = LoadingStatus.none,
        example = '',
        selectedTabIndex = 0;

  MyState copyWith({
    LoadingStatus? loadingStatus,
    String? example,
    int? selectedTabIndex,
  }) =>
      MyState(
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
