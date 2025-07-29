import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';
import '../../domain/meal/model/meal_model.dart';

class MealSearchState extends Equatable {
  // 식사 목록 조회
  final LoadingStatus getMealsLoadingStatus;
  final List<MealModel> mealList;
  final DateTime cursor;
  final bool hasNextPage;

  // 식사 검색
  final LoadingStatus searchMealsLoadingStatus;
  final bool isSearched;
  final String searchKeyword;
  final List<MealModel> searchMealList;

  const MealSearchState({
    required this.getMealsLoadingStatus,
    required this.mealList,
    required this.searchMealsLoadingStatus,
    required this.isSearched,
    required this.searchKeyword,
    required this.searchMealList,
    required this.cursor,
    required this.hasNextPage,
  });

  MealSearchState.init()
      : getMealsLoadingStatus = LoadingStatus.none,
        mealList = <MealModel>[],
        searchMealsLoadingStatus = LoadingStatus.none,
        isSearched = false,
        searchKeyword = '',
        searchMealList = <MealModel>[],
        cursor = DateTime(2100),
        hasNextPage = true;

  MealSearchState copyWith({
    LoadingStatus? getMealsLoadingStatus,
    List<MealModel>? mealList,
    LoadingStatus? searchMealsLoadingStatus,
    bool? isSearched,
    String? searchKeyword,
    List<MealModel>? searchMealList,
    DateTime? cursor,
    bool? hasNextPage,
  }) =>
      MealSearchState(
        getMealsLoadingStatus:
            getMealsLoadingStatus ?? this.getMealsLoadingStatus,
        mealList: mealList ?? this.mealList,
        searchMealsLoadingStatus:
            searchMealsLoadingStatus ?? this.searchMealsLoadingStatus,
        isSearched: isSearched ?? this.isSearched,
        searchKeyword: searchKeyword ?? this.searchKeyword,
        searchMealList: searchMealList ?? this.searchMealList,
        cursor: cursor ?? this.cursor,
        hasNextPage: hasNextPage ?? this.hasNextPage,
      );

  @override
  List<Object> get props => <Object>[
        getMealsLoadingStatus,
        mealList,
        searchMealsLoadingStatus,
        isSearched,
        searchKeyword,
        searchMealList,
        cursor,
        hasNextPage,
      ];
}
