import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'frequently_eaten_foods_state.dart';

final AutoDisposeStateNotifierProvider<FrequentlyEatenFoodsViewModel,
        FrequentlyEatenFoodsState> frequentlyEatenFoodsViewModelProvider =
    StateNotifierProvider.autoDispose(
  (Ref<FrequentlyEatenFoodsState> ref) => FrequentlyEatenFoodsViewModel(
    state: const FrequentlyEatenFoodsState.init(),
  ),
);

class FrequentlyEatenFoodsViewModel
    extends StateNotifier<FrequentlyEatenFoodsState> {
  FrequentlyEatenFoodsViewModel({
    required FrequentlyEatenFoodsState state,
  }) : super(state);

  void onTabChanged({required int index}) {
    state = state.copyWith(selectedTabIndex: index);
  }
}
