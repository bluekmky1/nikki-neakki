import 'package:equatable/equatable.dart';

import '../../core/loading_status.dart';
import '../../domain/food_category/model/food_category_model.dart';

class CategoryState extends Equatable {
  final LoadingStatus createFoodCategoryLoadingStatus;

  final LoadingStatus getFoodCategoriesLoadingStatus;
  final List<FoodCategoryModel> myFoodCategories;
  final LoadingStatus getPartnerFoodCategoriesLoadingStatus;
  final List<FoodCategoryModel> partnerFoodCategories;

  const CategoryState({
    required this.createFoodCategoryLoadingStatus,
    required this.getFoodCategoriesLoadingStatus,
    required this.myFoodCategories,
    required this.getPartnerFoodCategoriesLoadingStatus,
    required this.partnerFoodCategories,
  });

  CategoryState.init()
      : createFoodCategoryLoadingStatus = LoadingStatus.none,
        getFoodCategoriesLoadingStatus = LoadingStatus.none,
        myFoodCategories = <FoodCategoryModel>[],
        getPartnerFoodCategoriesLoadingStatus = LoadingStatus.none,
        partnerFoodCategories = <FoodCategoryModel>[];

  CategoryState copyWith({
    LoadingStatus? createFoodCategoryLoadingStatus,
    LoadingStatus? getFoodCategoriesLoadingStatus,
    List<FoodCategoryModel>? myFoodCategories,
    LoadingStatus? getPartnerFoodCategoriesLoadingStatus,
    List<FoodCategoryModel>? partnerFoodCategories,
  }) =>
      CategoryState(
        createFoodCategoryLoadingStatus: createFoodCategoryLoadingStatus ??
            this.createFoodCategoryLoadingStatus,
        getFoodCategoriesLoadingStatus: getFoodCategoriesLoadingStatus ??
            this.getFoodCategoriesLoadingStatus,
        myFoodCategories: myFoodCategories ?? this.myFoodCategories,
        partnerFoodCategories:
            partnerFoodCategories ?? this.partnerFoodCategories,
        getPartnerFoodCategoriesLoadingStatus:
            getPartnerFoodCategoriesLoadingStatus ??
                this.getPartnerFoodCategoriesLoadingStatus,
      );

  @override
  List<Object> get props => <Object>[
        createFoodCategoryLoadingStatus,
        getFoodCategoriesLoadingStatus,
        myFoodCategories,
        getPartnerFoodCategoriesLoadingStatus,
        partnerFoodCategories,
      ];
}
