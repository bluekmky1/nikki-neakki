import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/common/use_case/use_case_result.dart';
import '../../core/loading_status.dart';
import '../../domain/meal/model/meal_model.dart';
import '../../domain/meal/use_case/delete_meal_use_case.dart';
import '../../domain/meal/use_case/get_meal_list_use_case.dart';
import '../../service/category/category_service.dart';
import '../../service/meal_mate/meal_mate_service.dart';
import '../../service/supabase/supabase_service.dart';
import '../../service/supabase/supabase_state.dart';
import 'home_state.dart';

final AutoDisposeStateNotifierProvider<HomeViewModel, HomeState>
    homeViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref<HomeState> ref) => HomeViewModel(
    state: HomeState.init(),
    supabaseState: ref.read(supabaseServiceProvider),
    categoryService: ref.read(categoryServiceProvider.notifier),
    mealMateService: ref.read(mealMateServiceProvider.notifier),
    getMealListUseCase: ref.read(getMealListUseCaseProvider),
    deleteMealUseCase: ref.read(deleteMealUseCaseProvider),
  ),
);

class HomeViewModel extends StateNotifier<HomeState> {
  final SupabaseState _supabaseState;
  final CategoryService _categoryService;
  final MealMateService _mealMateService;
  final GetMealListUseCase _getMealListUseCase;
  final DeleteMealUseCase _deleteMealUseCase;

  HomeViewModel({
    required HomeState state,
    required SupabaseState supabaseState,
    required CategoryService categoryService,
    required MealMateService mealMateService,
    required GetMealListUseCase getMealListUseCase,
    required DeleteMealUseCase deleteMealUseCase,
  })  : _supabaseState = supabaseState,
        _categoryService = categoryService,
        _mealMateService = mealMateService,
        _getMealListUseCase = getMealListUseCase,
        _deleteMealUseCase = deleteMealUseCase,
        super(state);

  Future<void> init() async {
    await _mealMateService.getMealMate();
    await _categoryService.getMyFoodCategories();
    await _categoryService.getPartnerFoodCategories();
    state = state.copyWith(
      myCategoryNames: _categoryService.state.myFoodCategories,
      otherCategoryNames: _categoryService.state.partnerFoodCategories,
    );
    await getMyMealList(date: DateTime.now());
    await getOtherMealList(date: DateTime.now());
  }

  Future<void> getMyMealList({
    required DateTime date,
  }) async {
    final DateTime normalizedDate = DateTime(date.year, date.month, date.day);
    state = state.copyWith(
      getMyMealsLoadingStatus: LoadingStatus.loading,
      myMeals: <MealModel>[],
    );

    final UseCaseResult<List<MealModel>> result = await _getMealListUseCase(
      userId: _supabaseState.userId,
      date: normalizedDate,
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

  Future<void> getOtherMealList({
    required DateTime date,
  }) async {
    if (state.partnerId.isEmpty) {
      state = state.copyWith(getOtherMealsLoadingStatus: LoadingStatus.success);
      return;
    }

    final DateTime normalizedDate = DateTime(date.year, date.month, date.day);
    state = state.copyWith(
      getOtherMealsLoadingStatus: LoadingStatus.loading,
      otherMeals: <MealModel>[],
    );

    final UseCaseResult<List<MealModel>> result = await _getMealListUseCase(
      userId: state.partnerId,
      date: normalizedDate,
    );

    switch (result) {
      case SuccessUseCaseResult<List<MealModel>>():
        state = state.copyWith(
          otherMeals: result.data,
          getOtherMealsLoadingStatus: LoadingStatus.success,
        );

      case FailureUseCaseResult<List<MealModel>>():
        state = state.copyWith(
          getOtherMealsLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> deleteMeal({
    required String mealId,
    required String imageUrl,
  }) async {
    state = state.copyWith(deleteMealLoadingStatus: LoadingStatus.loading);

    final UseCaseResult<void> result = await _deleteMealUseCase(
      userId: _supabaseState.userId,
      mealId: mealId,
      imageUrl: imageUrl,
    );

    switch (result) {
      case SuccessUseCaseResult<void>():
        state = state.copyWith(
          myMeals: state.myMeals
              .where((MealModel meal) => meal.id != mealId)
              .toList(),
          deleteMealLoadingStatus: LoadingStatus.success,
        );

      case FailureUseCaseResult<void>():
        state = state.copyWith(
          deleteMealLoadingStatus: LoadingStatus.error,
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

  void onCreateMeal({required MealModel meal}) {
    state = state.copyWith(
      myMeals: <MealModel>[...state.myMeals, meal],
    );
  }
}
