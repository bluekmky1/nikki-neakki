import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/food_category/model/food_category_model.dart';
import '../../../domain/meal/model/meal_model.dart';
import '../../../routes/routes.dart';
import '../../common/consts/meal_type.dart';
import '../../common/widgets/card/action_card_widget.dart';
import '../home_state.dart';
import '../home_view_model.dart';
import 'meal_card_widget.dart';

class MealListWidget extends ConsumerWidget {
  const MealListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeState state = ref.watch(homeViewModelProvider);

    final List<MealModel> meals =
        state.selectedTabIndex == 0 ? state.myMeals : state.otherMeals;

    final List<FoodCategoryModel> categoryNames = state.selectedTabIndex == 0
        ? state.myCategoryNames
        : state.otherCategoryNames;

    final List<MealType> mealTypes = MealType.values
        .where((MealType mealType) => mealType != MealType.none)
        .toList();

    return Column(
      children: List<Widget>.generate(
        mealTypes.length,
        (int index) {
          final MealType mealType = mealTypes[index];

          if (meals.any((MealModel meal) => meal.mealType == mealType)) {
            final MealModel meal = meals.firstWhere(
              (MealModel meal) => meal.mealType == mealType,
            );

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: MealCardWidget(
                meal: meal,
                categoryNames: categoryNames,
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ActionCardWidget(
                title: mealType.name,
                onTap: () {
                  context.pushNamed(
                    Routes.recordFood.name,
                    pathParameters: <String, String>{
                      'mealType': mealType.name,
                    },
                    extra: state.selectedDate,
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
