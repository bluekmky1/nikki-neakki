import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/loading_status.dart';
import '../../domain/meal/model/food_model.dart';
import '../../domain/meal/model/meal_model.dart';
import '../common/consts/meal_type.dart';
import 'meal_detail_state.dart';

final AutoDisposeStateNotifierProvider<MealDetailViewModel, MealDetailState>
    mealDetailViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref<MealDetailState> ref) => MealDetailViewModel(
    state: const MealDetailState.init(),
  ),
);

class MealDetailViewModel extends StateNotifier<MealDetailState> {
  MealDetailViewModel({
    required MealDetailState state,
  }) : super(state);

  void loadMealDetail({required String mealId}) {
    state = state.copyWith(loadingStatus: LoadingStatus.loading);

    // 임시 데이터
    final MealModel mockMeal = MealModel(
      id: mealId,
      imageUrl: '',
      userId: '1',
      mealTime: DateTime.now(),
      mealType: MealType.lunch,
      foods: const <FoodModel>[
        FoodModel(id: '1', name: '김치볶음밥', categoryId: '1'),
        FoodModel(id: '2', name: '계란후라이', categoryId: '2'),
        FoodModel(id: '3', name: '미소된장국', categoryId: '3'),
      ],
      createdAt: DateTime.now(),
    );

    state = state.copyWith(
      loadingStatus: LoadingStatus.success,
      meal: mockMeal,
      isMyMeal: true,
      partnerNickname: '상대방닉네임',
    );
  }

  void showDeleteConfirmation() {
    state = state.copyWith(showDeleteConfirmation: true);
  }

  void hideDeleteConfirmation() {
    state = state.copyWith(showDeleteConfirmation: false);
  }

  void deleteMeal() {
    if (state.meal == null) {
      return;
    }

    state = state.copyWith(loadingStatus: LoadingStatus.loading);

    // 임시로 성공 처리
    state = state.copyWith(
      loadingStatus: LoadingStatus.success,
      showDeleteConfirmation: false,
    );
  }

  void editMeal() {}
}
