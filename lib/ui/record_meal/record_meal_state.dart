import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/loading_status.dart';
import '../../domain/food_category/model/food_category_model.dart';
import '../../domain/meal/model/food_model.dart';
import '../common/consts/meal_type.dart';

class RecordMealState extends Equatable {
  final LoadingStatus createFoodCategoryLoadingStatus;
  final LoadingStatus saveMealLoadingStatus;

  // 음식 추가 화면
  // 시간 선택
  final DateTime initialMealTime;
  final DateTime mealTime;
  final MealType mealType;

  // 음식 카테고리 선택
  final String selectedFoodCategoryId;
  final String selectedFoodCategoryName;
  final List<FoodModel> foods;
  // 카테고리 선택 바텀 시트
  final String searchKeyword;
  final List<FoodCategoryModel> allFoodCategories;
  final List<FoodCategoryModel> searchedFoodCategories;
  final XFile pickedImage;

  const RecordMealState({
    required this.createFoodCategoryLoadingStatus,
    required this.initialMealTime,
    required this.mealTime,
    required this.selectedFoodCategoryId,
    required this.selectedFoodCategoryName,
    required this.foods,
    required this.searchKeyword,
    required this.allFoodCategories,
    required this.searchedFoodCategories,
    required this.pickedImage,
    required this.mealType,
    required this.saveMealLoadingStatus,
  });

  RecordMealState.init()
      : createFoodCategoryLoadingStatus = LoadingStatus.none,
        initialMealTime = DateTime.now(),
        mealTime = DateTime.now(),
        selectedFoodCategoryId = '',
        selectedFoodCategoryName = '',
        foods = const <FoodModel>[],
        searchKeyword = '',
        allFoodCategories = const <FoodCategoryModel>[],
        searchedFoodCategories = const <FoodCategoryModel>[],
        pickedImage = XFile(''),
        mealType = MealType.none,
        saveMealLoadingStatus = LoadingStatus.none;

  RecordMealState copyWith({
    LoadingStatus? createFoodCategoryLoadingStatus,
    DateTime? initialMealTime,
    DateTime? mealTime,
    String? selectedFoodCategoryId,
    String? selectedFoodCategoryName,
    List<FoodModel>? foods,
    String? searchKeyword,
    List<FoodCategoryModel>? allFoodCategories,
    List<FoodCategoryModel>? searchedFoodCategories,
    XFile? pickedImage,
    MealType? mealType,
    LoadingStatus? saveMealLoadingStatus,
  }) =>
      RecordMealState(
        createFoodCategoryLoadingStatus: createFoodCategoryLoadingStatus ??
            this.createFoodCategoryLoadingStatus,
        initialMealTime: initialMealTime ?? this.initialMealTime,
        mealTime: mealTime ?? this.mealTime,
        selectedFoodCategoryId:
            selectedFoodCategoryId ?? this.selectedFoodCategoryId,
        selectedFoodCategoryName:
            selectedFoodCategoryName ?? this.selectedFoodCategoryName,
        foods: foods ?? this.foods,
        searchKeyword: searchKeyword ?? this.searchKeyword,
        allFoodCategories: allFoodCategories ?? this.allFoodCategories,
        searchedFoodCategories:
            searchedFoodCategories ?? this.searchedFoodCategories,
        pickedImage: pickedImage ?? this.pickedImage,
        mealType: mealType ?? this.mealType,
        saveMealLoadingStatus:
            saveMealLoadingStatus ?? this.saveMealLoadingStatus,
      );

  @override
  List<Object?> get props => <Object?>[
        createFoodCategoryLoadingStatus,
        initialMealTime,
        mealTime,
        selectedFoodCategoryId,
        selectedFoodCategoryName,
        foods,
        searchKeyword,
        allFoodCategories,
        searchedFoodCategories,
        pickedImage,
        mealType,
        saveMealLoadingStatus,
      ];

  bool get canSave => foods.isNotEmpty && pickedImage.path.isNotEmpty;
}
