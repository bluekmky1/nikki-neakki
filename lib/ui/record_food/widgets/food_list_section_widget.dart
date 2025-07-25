import 'package:flutter/material.dart';

import '../../../domain/meal/model/food_model.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class FoodListSectionWidget extends StatelessWidget {
  final List<FoodModel> foods;
  final void Function(int) onDeleteFood;

  const FoodListSectionWidget({
    required this.foods,
    required this.onDeleteFood,
    super.key,
  });

  @override
  Widget build(BuildContext context) => SliverList.builder(
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
                  foods[index].categoryName,
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
