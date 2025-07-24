import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/meal/model/food_model.dart';
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

  Future<void> addToCategory({required String category}) async {
    state = state.copyWith(
      allFoodCategories: <String>[...state.allFoodCategories, category],
      searchedFoodCategories: <String>[...state.allFoodCategories, category],
    );
  }

  void onSearchFoodCategory({required String searchKeyword}) {
    state = state.copyWith(
      searchKeyword: searchKeyword,
      searchedFoodCategories: state.allFoodCategories
          .where((String foodCategory) =>
              foodCategory.toLowerCase().contains(searchKeyword.toLowerCase()))
          .toList(),
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
}
