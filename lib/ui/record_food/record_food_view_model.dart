import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/loading_status.dart';
import '../../domain/meal/model/food_model.dart';
import '../../ui/common/consts/meal_type.dart';
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

  // 새 음식 카테고리 생성
  Future<void> addToCategory({required String category}) async {}

  // 음식 카테고리 검색
  Future<void> onSearchFoodCategory({required String searchKeyword}) async {
    state = state.copyWith(
      searchKeyword: searchKeyword,
      loadingStatus: LoadingStatus.loading,
    );

    state = state.copyWith(
      loadingStatus: LoadingStatus.success,
      searchedFoodCategories: <String>[],
    );
  }

  void onSelectFoodCategory({required String category}) {
    state = state.copyWith(
      selectedFoodCategory: category,
    );
  }

  void addFood({required String foodName}) {
    state = state.copyWith(
      foods: <FoodModel>[
        ...state.foods,
        FoodModel(
          id: '',
          name: foodName,
          categoryName: state.selectedFoodCategory,
        ),
      ],
    );

    state = state.copyWith(
      selectedFoodCategory: '',
    );
  }

  void deleteFood({required int foodIndex}) {
    state = state.copyWith(
      foods: List<FoodModel>.from(state.foods)..removeAt(foodIndex),
    );
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      state = state.copyWith(pickedImage: image);
    }
  }

  Future<void> pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      state = state.copyWith(pickedImage: image);
    }
  }

  // 식사 데이터 저장
  Future<bool> saveMeal({
    required MealType mealType,
    required DateTime mealTime,
  }) async {
    if (!state.canSave) {
      return false;
    }

    state = state.copyWith(loadingStatus: LoadingStatus.loading);

    String imageUrl = '';
    if (state.pickedImage != null) {
      // 이미지 업로드 로직 구현 필요
      imageUrl = 'https://example.com/uploaded-image.jpg';
    }

    state = state.copyWith(loadingStatus: LoadingStatus.success);
    return true;
  }

  // 폼 초기화
  void resetForm() {
    state = const RecordFoodState.init();
  }
}
