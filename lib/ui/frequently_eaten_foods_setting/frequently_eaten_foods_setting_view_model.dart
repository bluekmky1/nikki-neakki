import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'frequently_eaten_foods_setting_state.dart';

final AutoDisposeStateNotifierProvider<FrequentlyEatenFoodsSettingViewModel,
        FrequentlyEatenFoodsSettingState>
    frequentlyEatenFoodsSettingViewModelProvider =
    StateNotifierProvider.autoDispose(
  (Ref<FrequentlyEatenFoodsSettingState> ref) =>
      FrequentlyEatenFoodsSettingViewModel(
    state: const FrequentlyEatenFoodsSettingState.init(),
  ),
);

class FrequentlyEatenFoodsSettingViewModel
    extends StateNotifier<FrequentlyEatenFoodsSettingState> {
  FrequentlyEatenFoodsSettingViewModel({
    required FrequentlyEatenFoodsSettingState state,
  }) : super(state);

  void onTabChanged({required int index}) {
    state = state.copyWith(selectedTabIndex: index);
  }
}
