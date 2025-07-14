import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_state.dart';

final AutoDisposeStateNotifierProvider<HomeViewModel, HomeState>
    homeViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref<HomeState> ref) => HomeViewModel(
    state: HomeState.init(),
  ),
);

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel({
    required HomeState state,
  }) : super(state);

  void selectDate({required DateTime date}) {
    state = state.copyWith(selectedDate: date);
  }

  void changeDisplayWeekStartDate({required DateTime date}) {
    state = state.copyWith(displayWeekStartDate: date);
  }

  void onTabChanged({required int index}) {
    state = state.copyWith(selectedTabIndex: index);
  }
}
