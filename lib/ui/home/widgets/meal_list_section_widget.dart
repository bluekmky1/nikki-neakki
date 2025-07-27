import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/food_category/model/food_category_model.dart';
import '../../../domain/meal/model/meal_model.dart';
import '../../../routes/routes.dart';
import '../../../service/category/category_service.dart';
import '../../../service/category/category_state.dart';
import '../../common/consts/meal_type.dart';
import '../../common/widgets/card/action_card_widget.dart';
import 'meal_card_widget.dart';
import 'no_partner_widget.dart';

class MealListSectionWidget extends ConsumerWidget {
  final bool hasPartner;
  final int selectedTabIndex;
  final List<MealModel> myMeals;
  final List<MealModel> otherMeals;

  const MealListSectionWidget({
    required this.hasPartner,
    required this.selectedTabIndex,
    required this.myMeals,
    required this.otherMeals,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<FoodCategoryModel> myCategoryNames = ref.watch(
      categoryServiceProvider
          .select((CategoryState state) => state.myFoodCategories),
    );
    final List<FoodCategoryModel> partnerCategoryNames = ref.watch(
      categoryServiceProvider
          .select((CategoryState state) => state.partnerFoodCategories),
    );
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            if (hasPartner || selectedTabIndex == 0)
              ..._buildMealList(
                meals: selectedTabIndex == 0 ? myMeals : otherMeals,
                context: context,
                categoryNames: selectedTabIndex == 0
                    ? myCategoryNames
                    : partnerCategoryNames,
              )
            else
              const NoPartnerWidget(),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildMealList({
    required List<MealModel> meals,
    required BuildContext context,
    required List<FoodCategoryModel> categoryNames,
  }) =>
      List<Widget>.generate(
        MealType.values.length,
        (int index) {
          if (meals.any(
            (MealModel meal) => meal.mealType == MealType.values[index],
          )) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: MealCardWidget(
                meal: meals.firstWhere(
                  (MealModel meal) => meal.mealType == MealType.values[index],
                ),
                categoryNames: categoryNames,
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ActionCardWidget(
                title: MealType.values[index].name,
                onTap: () {
                  context.pushNamed(
                    Routes.recordFood.name,
                    pathParameters: <String, String>{
                      'mealType': MealType.values[index].name,
                    },
                  );
                },
              ),
            );
          }
        },
      );
}
