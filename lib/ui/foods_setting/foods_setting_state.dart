import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';
import '../../domain/food_category/model/food_category_model.dart';

class FoodsSettingState extends Equatable {
  final LoadingStatus getFoodCategoriesLoadingStatus;
  final LoadingStatus createFoodCategoryLoadingStatus;
  final LoadingStatus deleteFoodCategoryLoadingStatus;
  final LoadingStatus updateFoodCategoryLoadingStatus;

  final List<FoodCategoryModel> foodCategories;

  const FoodsSettingState({
    required this.getFoodCategoriesLoadingStatus,
    required this.createFoodCategoryLoadingStatus,
    required this.deleteFoodCategoryLoadingStatus,
    required this.updateFoodCategoryLoadingStatus,
    required this.foodCategories,
  });

  FoodsSettingState.init()
      : getFoodCategoriesLoadingStatus = LoadingStatus.none,
        createFoodCategoryLoadingStatus = LoadingStatus.none,
        deleteFoodCategoryLoadingStatus = LoadingStatus.none,
        updateFoodCategoryLoadingStatus = LoadingStatus.none,
        foodCategories = <FoodCategoryModel>[];

  FoodsSettingState copyWith({
    LoadingStatus? getFoodCategoriesLoadingStatus,
    LoadingStatus? createFoodCategoryLoadingStatus,
    LoadingStatus? deleteFoodCategoryLoadingStatus,
    LoadingStatus? updateFoodCategoryLoadingStatus,
    List<FoodCategoryModel>? foodCategories,
  }) =>
      FoodsSettingState(
        getFoodCategoriesLoadingStatus: getFoodCategoriesLoadingStatus ??
            this.getFoodCategoriesLoadingStatus,
        createFoodCategoryLoadingStatus: createFoodCategoryLoadingStatus ??
            this.createFoodCategoryLoadingStatus,
        deleteFoodCategoryLoadingStatus: deleteFoodCategoryLoadingStatus ??
            this.deleteFoodCategoryLoadingStatus,
        updateFoodCategoryLoadingStatus: updateFoodCategoryLoadingStatus ??
            this.updateFoodCategoryLoadingStatus,
        foodCategories: foodCategories ?? this.foodCategories,
      );

  @override
  List<Object> get props => <Object>[
        getFoodCategoriesLoadingStatus,
        createFoodCategoryLoadingStatus,
        deleteFoodCategoryLoadingStatus,
        updateFoodCategoryLoadingStatus,
        foodCategories,
      ];
}
