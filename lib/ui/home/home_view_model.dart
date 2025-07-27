import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/common/use_case/use_case_result.dart';
import '../../core/loading_status.dart';
import '../../domain/meal/model/meal_model.dart';
import '../../domain/meal/use_case/get_meal_list_use_case.dart';
import '../../service/meal_mate/meal_mate_service.dart';
import '../../service/meal_mate/meal_mate_state.dart';
import '../../service/supabase/supabase_service.dart';
import '../../service/supabase/supabase_state.dart';
import 'home_state.dart';

final AutoDisposeStateNotifierProvider<HomeViewModel, HomeState>
    homeViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref<HomeState> ref) => HomeViewModel(
    state: HomeState.init(),
    supabaseState: ref.read(supabaseServiceProvider),
    mealMateState: ref.read(mealMateServiceProvider),
    getMealListUseCase: ref.read(getMealListUseCaseProvider),
  ),
);

class HomeViewModel extends StateNotifier<HomeState> {
  final SupabaseState _supabaseState;
  final MealMateState _mealMateState;

  final GetMealListUseCase _getMealListUseCase;

  HomeViewModel({
    required HomeState state,
    required SupabaseState supabaseState,
    required MealMateState mealMateState,
    required GetMealListUseCase getMealListUseCase,
  })  : _supabaseState = supabaseState,
        _mealMateState = mealMateState,
        _getMealListUseCase = getMealListUseCase,
        super(state);

  Future<void> getMyMealList({
    required DateTime date,
  }) async {
    state = state.copyWith(getMyMealsLoadingStatus: LoadingStatus.loading);

    final UseCaseResult<List<MealModel>> result = await _getMealListUseCase(
      userId: _supabaseState.userId,
      date: date,
    );

    switch (result) {
      case SuccessUseCaseResult<List<MealModel>>():
        state = state.copyWith(
          myMeals: result.data,
          getMyMealsLoadingStatus: LoadingStatus.success,
        );

      case FailureUseCaseResult<List<MealModel>>():
        state = state.copyWith(
          getMyMealsLoadingStatus: LoadingStatus.error,
        );
    }
  }

  void selectDate({required DateTime date}) {
    state = state.copyWith(selectedDate: date);
    // 날짜가 변경되면 해당 날짜의 식사 데이터를 로드
    getMyMealList(date: date);
  }

  void jumpToDate({required DateTime date}) {
    state = state.copyWith(selectedDate: date);

    // 선택된 날짜가 속한 주의 월요일을 계산하여 displayWeekStartDate 업데이트
    final DateTime monday =
        date.subtract(Duration(days: (date.weekday + 6) % 7));
    state = state.copyWith(displayWeekStartDate: monday, shouldJump: true);

    getMyMealList(date: date);
  }

  void changeDisplayWeekStartDate({required DateTime date}) {
    state = state.copyWith(displayWeekStartDate: date);
  }

  void onTabChanged({required int index}) {
    state = state.copyWith(selectedTabIndex: index);
  }

  void resetJumpFlag() {
    state = state.copyWith(shouldJump: false);
  }
}
