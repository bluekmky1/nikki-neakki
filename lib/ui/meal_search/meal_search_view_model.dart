import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'meal_search_state.dart';

final AutoDisposeStateNotifierProvider<MealSearchViewModel, MealSearchState>
    mealSearchViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref<MealSearchState> ref) => MealSearchViewModel(
    state: MealSearchState.init(),
  ),
);

class MealSearchViewModel extends StateNotifier<MealSearchState> {
  MealSearchViewModel({
    required MealSearchState state,
  }) : super(state);
}
