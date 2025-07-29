import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/common/use_case/use_case_result.dart';
import '../../core/loading_status.dart';
import '../../domain/food_category/model/food_category_model.dart';
import '../../domain/food_category/use_case/create_food_category_use_case.dart';
import '../../domain/meal/model/food_model.dart';
import '../../domain/meal/use_case/create_meal_use_case.dart';
import '../../service/category/category_service.dart';
import '../../service/category/category_state.dart';
import '../../service/supabase/supabase_service.dart';
import '../../service/supabase/supabase_state.dart';
import '../common/consts/meal_type.dart';
import 'record_meal_state.dart';

final AutoDisposeStateNotifierProvider<RecordMealViewModel, RecordMealState>
    recordMealViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref<RecordMealState> ref) => RecordMealViewModel(
    categoryService: ref.read(categoryServiceProvider.notifier),
    categoryState: ref.read(categoryServiceProvider),
    supabaseState: ref.read(supabaseServiceProvider),
    createFoodCategoryUseCase: ref.read(createFoodCategoryUseCaseProvider),
    createMealUseCase: ref.read(createMealUseCaseProvider),
    state: RecordMealState.init(),
  ),
);

class RecordMealViewModel extends StateNotifier<RecordMealState> {
  final CategoryState _categoryState;
  final CategoryService _categoryService;
  final SupabaseState _supabaseState;
  final CreateFoodCategoryUseCase _createFoodCategoryUseCase;
  final CreateMealUseCase _createMealUseCase;
  RecordMealViewModel({
    required CategoryState categoryState,
    required CategoryService categoryService,
    required SupabaseState supabaseState,
    required CreateFoodCategoryUseCase createFoodCategoryUseCase,
    required CreateMealUseCase createMealUseCase,
    required RecordMealState state,
  })  : _categoryState = categoryState,
        _categoryService = categoryService,
        _supabaseState = supabaseState,
        _createFoodCategoryUseCase = createFoodCategoryUseCase,
        _createMealUseCase = createMealUseCase,
        super(state);

  void init({required String mealType, required DateTime date}) {
    state = state.copyWith(
      allFoodCategories: _categoryState.myFoodCategories,
      searchedFoodCategories: _categoryState.myFoodCategories,
      mealType: MealType.fromString(mealType),
      initialMealTime: DateTime(date.year, date.month, date.day),
      mealTime: DateTime(date.year, date.month, date.day),
    );
    if (date.year == DateTime.now().year &&
        date.month == DateTime.now().month &&
        date.day == DateTime.now().day) {
      state = state.copyWith(
        initialMealTime: DateTime.now(),
        mealTime: DateTime.now(),
      );
    }
  }

  // 새 음식 카테고리 생성
  Future<void> addToCategory({required String category}) async {
    if (state.saveMealLoadingStatus == LoadingStatus.loading) {
      return;
    }

    state = state.copyWith(
      createFoodCategoryLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<FoodCategoryModel> result =
        await _createFoodCategoryUseCase(
      userId: _supabaseState.userId,
      name: category,
    );

    switch (result) {
      case SuccessUseCaseResult<FoodCategoryModel>(
          data: final FoodCategoryModel data
        ):
        state = state.copyWith(
          allFoodCategories: <FoodCategoryModel>[
            ...state.allFoodCategories,
            data
          ],
          searchedFoodCategories: <FoodCategoryModel>[
            ...state.allFoodCategories,
            data
          ],
          createFoodCategoryLoadingStatus: LoadingStatus.success,
          searchKeyword: '',
          selectedFoodCategoryId: data.id,
          selectedFoodCategoryName: data.name,
        );
        _categoryService.createFoodCategory(foodCategory: data);
      case FailureUseCaseResult<FoodCategoryModel>():
        state = state.copyWith(
          createFoodCategoryLoadingStatus: LoadingStatus.error,
        );
    }
  }

  // 음식 카테고리 검색
  void onSearchFoodCategory({required String searchKeyword}) {
    state = state.copyWith(
      searchKeyword: searchKeyword,
    );

    state = state.copyWith(
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
      searchedFoodCategories: state.allFoodCategories,
      searchKeyword: '',
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
  Future<void> saveMeal() async {
    if (!state.canSave) {
      return;
    }
    state = state.copyWith(saveMealLoadingStatus: LoadingStatus.loading);
    final UseCaseResult<void> result = await _createMealUseCase(
      userId: _supabaseState.userId,
      date: state.mealTime,
      mealType: state.mealType,
      image: state.pickedImage,
      foods: state.foods,
    );

    switch (result) {
      case SuccessUseCaseResult<void>():
        state = state.copyWith(saveMealLoadingStatus: LoadingStatus.success);
      case FailureUseCaseResult<void>():
        state = state.copyWith(saveMealLoadingStatus: LoadingStatus.error);
    }
  }
}
