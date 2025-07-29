import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/common/use_case/use_case_result.dart';
import '../../core/loading_status.dart';
import '../../domain/food_category/model/food_category_model.dart';
import '../../domain/food_category/use_case/create_food_category_use_case.dart';
import '../../domain/food_category/use_case/delete_food_category_use_case.dart';
import '../../domain/food_category/use_case/update_food_category_use_case.dart';
import '../../service/category/category_service.dart';
import '../../service/supabase/supabase_service.dart';
import '../../service/supabase/supabase_state.dart';
import 'foods_setting_state.dart';

final AutoDisposeStateNotifierProvider<FoodsSettingViewModel, FoodsSettingState>
    foodsSettingViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref<FoodsSettingState> ref) => FoodsSettingViewModel(
    state: FoodsSettingState.init(),
    createFoodCategoryUseCase: ref.read(createFoodCategoryUseCaseProvider),
    deleteFoodCategoryUseCase: ref.read(deleteFoodCategoryUseCaseProvider),
    updateFoodCategoryUseCase: ref.read(updateFoodCategoryUseCaseProvider),
    supabaseState: ref.read(supabaseServiceProvider),
    categoryService: ref.read(categoryServiceProvider.notifier),
  ),
);

class FoodsSettingViewModel extends StateNotifier<FoodsSettingState> {
  final CreateFoodCategoryUseCase _createFoodCategoryUseCase;
  final DeleteFoodCategoryUseCase _deleteFoodCategoryUseCase;
  final UpdateFoodCategoryUseCase _updateFoodCategoryUseCase;
  final SupabaseState _supabaseState;
  final CategoryService _categoryService;
  FoodsSettingViewModel({
    required FoodsSettingState state,
    required CreateFoodCategoryUseCase createFoodCategoryUseCase,
    required DeleteFoodCategoryUseCase deleteFoodCategoryUseCase,
    required UpdateFoodCategoryUseCase updateFoodCategoryUseCase,
    required SupabaseState supabaseState,
    required CategoryService categoryService,
  })  : _createFoodCategoryUseCase = createFoodCategoryUseCase,
        _deleteFoodCategoryUseCase = deleteFoodCategoryUseCase,
        _updateFoodCategoryUseCase = updateFoodCategoryUseCase,
        _supabaseState = supabaseState,
        _categoryService = categoryService,
        super(state);

  void init({required List<FoodCategoryModel> foodCategories}) {
    state = state.copyWith(
      foodCategories: foodCategories,
    );
  }

  Future<void> createFoodCategory({required String name}) async {
    state = state.copyWith(
      getFoodCategoriesLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<FoodCategoryModel> result =
        await _createFoodCategoryUseCase(
      userId: _supabaseState.userId,
      name: name,
    );

    switch (result) {
      case SuccessUseCaseResult<FoodCategoryModel>():
        state = state.copyWith(
          foodCategories: <FoodCategoryModel>[
            ...state.foodCategories,
            result.data,
          ],
          createFoodCategoryLoadingStatus: LoadingStatus.success,
        );
        _categoryService.createFoodCategory(foodCategory: result.data);

      case FailureUseCaseResult<FoodCategoryModel>():
        state = state.copyWith(
          createFoodCategoryLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> deleteFoodCategory({required String foodCategoryId}) async {
    state = state.copyWith(
      deleteFoodCategoryLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<void> result = await _deleteFoodCategoryUseCase(
      foodCategoryId: foodCategoryId,
    );

    switch (result) {
      case SuccessUseCaseResult<void>():
        state = state.copyWith(
          deleteFoodCategoryLoadingStatus: LoadingStatus.success,
          foodCategories: state.foodCategories
              .where((FoodCategoryModel foodCategory) =>
                  foodCategory.id != foodCategoryId)
              .toList(),
        );
        _categoryService.deleteFoodCategory(foodCategoryId: foodCategoryId);

      case FailureUseCaseResult<void>():
        state = state.copyWith(
          deleteFoodCategoryLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> updateFoodCategory({
    required String foodCategoryId,
    required String name,
  }) async {
    state = state.copyWith(
      updateFoodCategoryLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<void> result = await _updateFoodCategoryUseCase(
      foodCategoryId: foodCategoryId,
      name: name,
    );

    switch (result) {
      case SuccessUseCaseResult<void>():
        state = state.copyWith(
          updateFoodCategoryLoadingStatus: LoadingStatus.success,
          foodCategories: state.foodCategories
              .map((FoodCategoryModel foodCategory) =>
                  foodCategory.id == foodCategoryId
                      ? foodCategory.copyWith(name: name)
                      : foodCategory)
              .toList(),
        );
        _categoryService.updateFoodCategory(
          foodCategoryId: foodCategoryId,
          name: name,
        );

      case FailureUseCaseResult<void>():
        state = state.copyWith(
          updateFoodCategoryLoadingStatus: LoadingStatus.error,
        );
    }
  }
}
