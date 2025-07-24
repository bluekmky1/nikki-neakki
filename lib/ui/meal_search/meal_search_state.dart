import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';
import '../../domain/meal/model/food_model.dart';
import '../../domain/meal/model/meal_model.dart';
import '../common/consts/meal_type.dart';

class MealSearchState extends Equatable {
  // 식사 목록 조회
  final LoadingStatus getMealsLoadingStatus;
  final List<MealModel> mealList;

  // 식사 검색
  final LoadingStatus searchMealsLoadingStatus;
  final String searchKeyword;
  final List<MealModel> searchMealList;

  const MealSearchState({
    required this.getMealsLoadingStatus,
    required this.mealList,
    required this.searchMealsLoadingStatus,
    required this.searchKeyword,
    required this.searchMealList,
  });

  MealSearchState.init()
      : getMealsLoadingStatus = LoadingStatus.none,
        mealList = <MealModel>[
          MealModel(
            id: '1',
            thumbnailUrl: 'https://via.placeholder.com/150',
            mealTime: DateTime.now(),
            mealType: MealType.breakfast,
            foods: const <FoodModel>[
              FoodModel(
                id: '1',
                name: '식사1',
                categoryName: '카테고리1',
              ),
              FoodModel(
                id: '1',
                name: '식사1',
                categoryName: '카테고리1',
              ),
            ],
          ),
          MealModel(
            id: '1',
            thumbnailUrl: 'https://via.placeholder.com/150',
            mealTime: DateTime.now(),
            mealType: MealType.breakfast,
            foods: const <FoodModel>[
              FoodModel(
                id: '1',
                name: '식사1',
                categoryName: '카테고리1',
              ),
              FoodModel(
                id: '1',
                name: '식사1',
                categoryName: '카테고리1',
              ),
            ],
          ),
          MealModel(
            id: '1',
            thumbnailUrl: 'https://via.placeholder.com/150',
            mealTime: DateTime.now(),
            mealType: MealType.breakfast,
            foods: const <FoodModel>[
              FoodModel(
                id: '1',
                name: '식사1',
                categoryName: '카테고리1',
              ),
              FoodModel(
                id: '1',
                name: '식사1',
                categoryName: '카테고리1',
              ),
            ],
          ),
        ],
        searchMealsLoadingStatus = LoadingStatus.none,
        searchKeyword = '',
        searchMealList = <MealModel>[
          MealModel(
            id: '1',
            thumbnailUrl: 'https://via.placeholder.com/150',
            mealTime: DateTime.now(),
            mealType: MealType.breakfast,
            foods: const <FoodModel>[
              FoodModel(
                id: '1',
                name: '식사1',
                categoryName: '카테고리1',
              ),
              FoodModel(
                id: '1',
                name: '식사1',
                categoryName: '카테고리1',
              ),
            ],
          ),
        ];

  MealSearchState copyWith({
    LoadingStatus? getMealsLoadingStatus,
    List<MealModel>? mealList,
    LoadingStatus? searchMealsLoadingStatus,
    String? searchKeyword,
    List<MealModel>? searchMealList,
  }) =>
      MealSearchState(
        getMealsLoadingStatus:
            getMealsLoadingStatus ?? this.getMealsLoadingStatus,
        mealList: mealList ?? this.mealList,
        searchMealsLoadingStatus:
            searchMealsLoadingStatus ?? this.searchMealsLoadingStatus,
        searchKeyword: searchKeyword ?? this.searchKeyword,
        searchMealList: searchMealList ?? this.searchMealList,
      );

  @override
  List<Object> get props => <Object>[
        getMealsLoadingStatus,
        mealList,
        searchMealsLoadingStatus,
        searchKeyword,
        searchMealList,
      ];
}
