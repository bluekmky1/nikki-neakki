import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/common/use_case/use_case_result.dart';
import '../../core/loading_status.dart';
import '../../domain/food_category/model/food_category_model.dart';
import '../../domain/food_category/use_case/get_food_category_use_case.dart';
import '../meal_mate/meal_mate_service.dart';
import '../meal_mate/meal_mate_state.dart';
import '../supabase/supabase_service.dart';
import '../supabase/supabase_state.dart';
import 'category_state.dart';

final StateNotifierProvider<CategoryService, CategoryState>
    categoryServiceProvider =
    StateNotifierProvider<CategoryService, CategoryState>(
  (Ref<CategoryState> ref) => CategoryService(
    state: CategoryState.init(),
    supabaseState: ref.read(supabaseServiceProvider),
    mealMateState: ref.read(mealMateServiceProvider),
    getFoodCategoryUseCase: ref.read(getFoodCategoryUseCaseProvider),
  ),
);

class CategoryService extends StateNotifier<CategoryState> {
  final SupabaseState _supabaseState;
  final MealMateState _mealMateState;
  final GetFoodCategoryUseCase _getFoodCategoryUseCase;
  CategoryService({
    required CategoryState state,
    required SupabaseState supabaseState,
    required MealMateState mealMateState,
    required GetFoodCategoryUseCase getFoodCategoryUseCase,
  })  : _supabaseState = supabaseState,
        _mealMateState = mealMateState,
        _getFoodCategoryUseCase = getFoodCategoryUseCase,
        super(state);

  Future<void> getMyFoodCategories() async {
    final UseCaseResult<List<FoodCategoryModel>> result =
        await _getFoodCategoryUseCase(userId: _supabaseState.userId);

    switch (result) {
      case SuccessUseCaseResult<List<FoodCategoryModel>>():
        state = state.copyWith(
          getFoodCategoriesLoadingStatus: LoadingStatus.success,
          myFoodCategories: result.data,
        );
      case FailureUseCaseResult<List<FoodCategoryModel>>():
        state = state.copyWith(
          getFoodCategoriesLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> getPartnerFoodCategories() async {
    if (!_mealMateState.hasMealMate) {
      return;
    }

    final UseCaseResult<List<FoodCategoryModel>> result =
        await _getFoodCategoryUseCase(userId: _mealMateState.mealMateUserId);

    switch (result) {
      case SuccessUseCaseResult<List<FoodCategoryModel>>():
        state = state.copyWith(
          getFoodCategoriesLoadingStatus: LoadingStatus.success,
          partnerFoodCategories: result.data,
        );
      case FailureUseCaseResult<List<FoodCategoryModel>>():
        state = state.copyWith(
          getFoodCategoriesLoadingStatus: LoadingStatus.error,
        );
    }
  }
}
