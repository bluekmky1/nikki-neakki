import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/loading_status.dart';
import '../../domain/food_category/model/food_category_model.dart';
import '../../domain/meal/model/food_model.dart';
import '../../service/category/category_service.dart';
import '../../service/category/category_state.dart';
import '../common/consts/meal_type.dart';
import 'record_food_state.dart';

final AutoDisposeStateNotifierProvider<RecordFoodViewModel, RecordFoodState>
    recordFoodViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref<RecordFoodState> ref) => RecordFoodViewModel(
    categoryState: ref.read(categoryServiceProvider),
    state: RecordFoodState.init(),
  ),
);

class RecordFoodViewModel extends StateNotifier<RecordFoodState> {
  final CategoryState _categoryState;

  RecordFoodViewModel({
    required CategoryState categoryState,
    required RecordFoodState state,
  })  : _categoryState = categoryState,
        super(state);

  void init({required String mealType}) {
    state = state.copyWith(
      allFoodCategories: _categoryState.myFoodCategories,
      searchedFoodCategories: _categoryState.myFoodCategories,
      mealType: MealType.fromString(mealType),
    );
  }

  // 새 음식 카테고리 생성
  Future<void> addToCategory({required String category}) async {
    state = state.copyWith(
      allFoodCategories: <FoodCategoryModel>[
        ..._categoryState.myFoodCategories,
        FoodCategoryModel(
          id: 'asd',
          name: category,
          createdAt: DateTime.now(),
        ),
      ],
      searchedFoodCategories: <FoodCategoryModel>[
        ..._categoryState.myFoodCategories,
        FoodCategoryModel(
          id: 'asd',
          name: category,
          createdAt: DateTime.now(),
        ),
      ],
      searchKeyword: '',
    );
  }

  // 음식 카테고리 검색
  Future<void> onSearchFoodCategory({required String searchKeyword}) async {
    state = state.copyWith(
      searchKeyword: searchKeyword,
      loadingStatus: LoadingStatus.loading,
    );

    state = state.copyWith(
      loadingStatus: LoadingStatus.success,
      searchedFoodCategories: _categoryState.myFoodCategories
          .where((FoodCategoryModel category) =>
              category.name.contains(searchKeyword))
          .toList(),
    );
  }

  void onSelectFoodCategory({
    required String categoryId,
    required String categoryName,
  }) {
    state = state.copyWith(
      selectedFoodCategoryId: categoryId,
      selectedFoodCategoryName: categoryName,
    );
  }

  void addFood({required String foodName}) {
    state = state.copyWith(
      foods: <FoodModel>[
        ...state.foods,
        FoodModel(
          id: '',
          name: foodName,
          categoryId: state.selectedFoodCategoryId,
        ),
      ],
    );

    state = state.copyWith(
      selectedFoodCategoryId: '',
      selectedFoodCategoryName: '',
    );
  }

  void deleteFood({required int foodIndex}) {
    state = state.copyWith(
      foods: List<FoodModel>.from(state.foods)..removeAt(foodIndex),
    );
  }

  void onChangeMealTime({required DateTime mealTime}) {
    state = state.copyWith(mealTime: mealTime);
  }

  void onConfirmMealTime({required DateTime mealTime}) {
    state = state.copyWith(
      mealTime: mealTime,
      initialMealTime: mealTime,
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

  // 사진 삭제
  void deleteImage() {
    state = state.copyWith(pickedImage: XFile(''));
  }

  // 식사 데이터 저장
  Future<bool> saveMeal() async {
    if (!state.canSave) {
      return false;
    }

    state = state.copyWith(loadingStatus: LoadingStatus.loading);

    if (state.pickedImage.path.isNotEmpty) {}

    state = state.copyWith(loadingStatus: LoadingStatus.success);
    return true;
  }
}
