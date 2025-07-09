import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'my_state.dart';

final AutoDisposeStateNotifierProvider<MyViewModel, MyState>
    myViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref<MyState> ref) => MyViewModel(
    state: const MyState.init(),
  ),
);

class MyViewModel extends StateNotifier<MyState> {
  MyViewModel({
    required MyState state,
  }) : super(state);

  void onTabChanged({required int index}) {
    state = state.copyWith(selectedTabIndex: index);
  }
}
