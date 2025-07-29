import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/food_category/model/food_category_model.dart';
import '../../../domain/meal/model/food_model.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../record_meal_state.dart';
import '../record_meal_view_model.dart';

class MealFoodListSectionWidget extends ConsumerWidget {
  final List<FoodModel> foods;
  final void Function(int) onDeleteFood;

  const MealFoodListSectionWidget({
    required this.foods,
    required this.onDeleteFood,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final RecordMealState state = ref.watch(recordMealViewModelProvider);
    return SliverList.builder(
      itemCount: foods.length,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: AppColors.gray100,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: AppColors.deepMain,
                ),
              ),
              child: Text(
                state.allFoodCategories
                    .firstWhere((FoodCategoryModel category) =>
                        category.id == foods[index].categoryId)
                    .name,
                style: AppTextStyles.textR14.copyWith(
                  color: AppColors.deepMain,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                foods[index].name,
                style: AppTextStyles.textR14.copyWith(
                  color: AppColors.gray900,
                ),
              ),
            ),
            const SizedBox(width: 16),
            IconButton(
              onPressed: () {
                onDeleteFood(index);
              },
              style: IconButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.zero,
                iconSize: 24,
              ),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }
}
