import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';

class FrequentlyEatenFoodsSettingState extends Equatable {
  final LoadingStatus loadingStatus;
  final String example;
  final int selectedTabIndex;

  const FrequentlyEatenFoodsSettingState({
    required this.loadingStatus,
    required this.example,
    required this.selectedTabIndex,
  });

  const FrequentlyEatenFoodsSettingState.init()
      : loadingStatus = LoadingStatus.none,
        example = '',
        selectedTabIndex = 0;

  FrequentlyEatenFoodsSettingState copyWith({
    LoadingStatus? loadingStatus,
    String? example,
    int? selectedTabIndex,
  }) =>
      FrequentlyEatenFoodsSettingState(
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
