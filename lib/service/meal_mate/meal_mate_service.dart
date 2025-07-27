import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/common/use_case/use_case_result.dart';
import '../../core/loading_status.dart';
import '../../domain/meal_mate/model/meal_mate_model.dart';
import '../../domain/meal_mate/use_case/get_meal_mate_use_case.dart';
import '../../domain/meal_mate/use_case/get_meal_mate_user_name_use_case.dart';
import '../supabase/supabase_service.dart';
import '../supabase/supabase_state.dart';
import 'meal_mate_state.dart';

final StateNotifierProvider<MealMateService, MealMateState>
    mealMateServiceProvider =
    StateNotifierProvider<MealMateService, MealMateState>(
  (Ref<MealMateState> ref) => MealMateService(
    state: const MealMateState.init(),
    supabaseState: ref.read(supabaseServiceProvider),
    getMealMateUseCase: ref.read(getMealMateUseCaseProvider),
    getMateUserNameUseCase: ref.read(getMealMateUserNameUseCaseProvider),
  ),
);

class MealMateService extends StateNotifier<MealMateState> {
  final SupabaseState _supabaseState;

  final GetMealMateUseCase _getMealMateUseCase;
  final GetMealMateUserNameUseCase _getMateUserNameUseCase;

  MealMateService({
    required MealMateState state,
    required SupabaseState supabaseState,
    required GetMealMateUseCase getMealMateUseCase,
    required GetMealMateUserNameUseCase getMateUserNameUseCase,
  })  : _supabaseState = supabaseState,
        _getMealMateUseCase = getMealMateUseCase,
        _getMateUserNameUseCase = getMateUserNameUseCase,
        super(state);

  Future<void> getMealMate() async {
    final UseCaseResult<MealMateModel> result =
        await _getMealMateUseCase.call(userId: _supabaseState.userId);

    switch (result) {
      case SuccessUseCaseResult<MealMateModel>():
        state = state.copyWith(
          mealMateId: result.data.id,
          mealMateUserId: result.data.user2Id,
          getMealMateLoadingStatus: LoadingStatus.success,
        );
      case FailureUseCaseResult<MealMateModel>():
        state = state.copyWith(
          mealMateId: '',
          mealMateUserId: '',
          getMealMateLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> getMateUserName() async {
    final UseCaseResult<String> result =
        await _getMateUserNameUseCase.call(userId: _supabaseState.userId);

    switch (result) {
      case SuccessUseCaseResult<String>():
        state = state.copyWith(
          mealMateUserName: result.data,
          getMateUserNameLoadingStatus: LoadingStatus.success,
        );
      case FailureUseCaseResult<String>():
        state = state.copyWith(
          mealMateUserName: '',
          getMateUserNameLoadingStatus: LoadingStatus.error,
        );
    }
  }
}
