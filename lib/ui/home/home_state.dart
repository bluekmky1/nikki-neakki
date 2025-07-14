import 'package:equatable/equatable.dart';
import '../../domain/meal/model/food_model.dart';
import '../../domain/meal/model/meal_model.dart';
import '../common/consts/meal_type.dart';

class HomeState extends Equatable {
  final DateTime selectedDate;
  final DateTime displayWeekStartDate;
  final int selectedTabIndex;
  final List<MealModel> myMeals;
  final List<MealModel> otherMeals;

  const HomeState({
    required this.selectedDate,
    required this.displayWeekStartDate,
    required this.selectedTabIndex,
    required this.myMeals,
    required this.otherMeals,
  });

  HomeState.init()
      : selectedDate = DateTime.now(),
        displayWeekStartDate = DateTime.now(),
        selectedTabIndex = 0,
        myMeals = <MealModel>[
          MealModel(
            id: '1',
            thumbnailUrl: 'https://via.placeholder.com/150',
            mealTime: DateTime.now(),
            mealType: MealType.breakfast,
            foods: const <FoodModel>[
              FoodModel(
                id: '1',
                name: '알리알리올리숑',
                category: '파스타',
              ),
            ],
          ),
        ],
        otherMeals = <MealModel>[];

  HomeState copyWith({
    DateTime? selectedDate,
    DateTime? displayWeekStartDate,
    int? selectedTabIndex,
    List<MealModel>? myMeals,
    List<MealModel>? otherMeals,
  }) =>
      HomeState(
        selectedDate: selectedDate ?? this.selectedDate,
        displayWeekStartDate: displayWeekStartDate ?? this.displayWeekStartDate,
        selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
        myMeals: myMeals ?? this.myMeals,
        otherMeals: otherMeals ?? this.otherMeals,
      );

  @override
  List<Object> get props => <Object>[
        selectedDate,
        selectedTabIndex,
        myMeals,
        otherMeals,
      ];

  bool get isToday {
    final DateTime now = DateTime.now();
    return selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day;
  }
}
