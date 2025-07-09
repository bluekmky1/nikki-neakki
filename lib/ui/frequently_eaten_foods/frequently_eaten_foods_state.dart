import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';

class FrequentlyEatenFoodsState extends Equatable {
  final LoadingStatus loadingStatus;
  final String example;
  final int selectedTabIndex;

  const FrequentlyEatenFoodsState({
    required this.loadingStatus,
    required this.example,
    required this.selectedTabIndex,
  });

  const FrequentlyEatenFoodsState.init()
      : loadingStatus = LoadingStatus.none,
        example = '',
        selectedTabIndex = 0;

  FrequentlyEatenFoodsState copyWith({
    LoadingStatus? loadingStatus,
    String? example,
    int? selectedTabIndex,
  }) =>
      FrequentlyEatenFoodsState(
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
