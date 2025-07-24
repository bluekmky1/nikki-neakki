import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'foods_setting_state.dart';

final AutoDisposeStateNotifierProvider<FoodsSettingViewModel, FoodsSettingState>
    frequentlyEatenFoodsSettingViewModelProvider =
    StateNotifierProvider.autoDispose(
  (Ref<FoodsSettingState> ref) => FoodsSettingViewModel(
    state: const FoodsSettingState.init(),
  ),
);

class FoodsSettingViewModel extends StateNotifier<FoodsSettingState> {
  FoodsSettingViewModel({
    required FoodsSettingState state,
  }) : super(state);

  void onTabChanged({required int index}) {
    state = state.copyWith(selectedTabIndex: index);
  }
}
