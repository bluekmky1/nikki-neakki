import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/loading_status.dart';
import 'record_food_state.dart';

final AutoDisposeStateNotifierProvider<RecordFoodViewModel, RecordFoodState>
    recordFoodViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref<RecordFoodState> ref) => RecordFoodViewModel(
    state: const RecordFoodState.init(),
  ),
);

class RecordFoodViewModel extends StateNotifier<RecordFoodState> {
  RecordFoodViewModel({
    required RecordFoodState state,
  }) : super(state);

  void onLogin() {
    state = state.copyWith(loadingStatus: LoadingStatus.loading);
  }
}
