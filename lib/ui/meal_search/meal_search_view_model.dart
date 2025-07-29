import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/common/use_case/use_case_result.dart';
import '../../core/loading_status.dart';
import '../../domain/meal/model/meal_model.dart';
import '../../domain/meal/use_case/get_meal_list_with_pagination_use_case.dart';
import '../../domain/meal/use_case/search_meal_use_case.dart';
import '../../service/supabase/supabase_service.dart';
import '../../service/supabase/supabase_state.dart';
import 'meal_search_state.dart';

final AutoDisposeStateNotifierProvider<MealSearchViewModel, MealSearchState>
    mealSearchViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref<MealSearchState> ref) => MealSearchViewModel(
    state: MealSearchState.init(),
    supabaseState: ref.read(supabaseServiceProvider),
    getMealListWithPaginationUseCase:
        ref.read(getMealListWithPaginationUseCaseProvider),
    searchMealUseCase: ref.read(searchMealUseCaseProvider),
  ),
);

class MealSearchViewModel extends StateNotifier<MealSearchState> {
  final GetMealListWithPaginationUseCase _getMealListWithPaginationUseCase;
  final SearchMealUseCase _searchMealUseCase;
  final SupabaseState _supabaseState;

  MealSearchViewModel({
    required MealSearchState state,
    required SupabaseState supabaseState,
    required GetMealListWithPaginationUseCase getMealListWithPaginationUseCase,
    required SearchMealUseCase searchMealUseCase,
  })  : _supabaseState = supabaseState,
        _getMealListWithPaginationUseCase = getMealListWithPaginationUseCase,
        _searchMealUseCase = searchMealUseCase,
        super(state);

  Future<void> getMealsListWithPagination() async {
    if (!state.hasNextPage) {
      return;
    }

    state = state.copyWith(getMealsLoadingStatus: LoadingStatus.loading);

    final String? cursor =
        state.mealList.isEmpty ? null : state.cursor.toIso8601String();

    final UseCaseResult<List<MealModel>> result =
        await _getMealListWithPaginationUseCase(
      userId: _supabaseState.userId,
      cursor: cursor,
    );

    switch (result) {
      case SuccessUseCaseResult<List<MealModel>>():
        if (result.data.isEmpty) {
          state = state.copyWith(
            getMealsLoadingStatus: LoadingStatus.success,
            hasNextPage: false,
          );
          return;
        }

        state = state.copyWith(
          getMealsLoadingStatus: LoadingStatus.success,
          mealList: <MealModel>[...state.mealList, ...result.data],
          cursor: result.data.last.createdAt,
        );

      case FailureUseCaseResult<List<MealModel>>():
        state = state.copyWith(
          getMealsLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> searchMeal({required String searchKeyword}) async {
    if (state.searchKeyword == searchKeyword ||
        state.searchMealsLoadingStatus == LoadingStatus.loading) {
      return;
    }

    state = state.copyWith(
      searchMealsLoadingStatus: LoadingStatus.loading,
      searchKeyword: searchKeyword,
    );

    final UseCaseResult<List<MealModel>> result = await _searchMealUseCase(
        userId: _supabaseState.userId, searchKeyword: searchKeyword);

    switch (result) {
      case SuccessUseCaseResult<List<MealModel>>():
        state = state.copyWith(
          searchMealsLoadingStatus: LoadingStatus.success,
          searchMealList: result.data,
          isSearched: true,
        );

      case FailureUseCaseResult<List<MealModel>>():
        state = state.copyWith(
          searchMealsLoadingStatus: LoadingStatus.error,
        );
    }
  }

  void clearSearchKeyword() {
    state = state.copyWith(
      searchKeyword: '',
      searchMealList: <MealModel>[],
      isSearched: false,
    );
  }
}
