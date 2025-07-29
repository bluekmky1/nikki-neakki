import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/food_category/model/food_category_model.dart';
import '../../../domain/meal/model/food_model.dart';
import '../../../domain/meal/model/meal_model.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../../util/date_time_formatter.dart';
import '../../common/widgets/button/bottom_sheet_row_button_widget.dart';
import '../../common/widgets/card/base_card_widget.dart';
import '../home_view_model.dart';

class MealCardWidget extends ConsumerStatefulWidget {
  const MealCardWidget({
    required this.meal,
    required this.categoryNames,
    super.key,
  });

  final MealModel meal;
  final List<FoodCategoryModel> categoryNames;

  @override
  ConsumerState<MealCardWidget> createState() => _MealCardWidgetState();
}

class _MealCardWidgetState extends ConsumerState<MealCardWidget> {
  bool _expanded = false;

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = ref.read(homeViewModelProvider.notifier);
    return BaseCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                widget.meal.mealType.name,
                style: AppTextStyles.textB16.copyWith(
                  color: AppColors.gray900,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                DateTimeFormatter.timeFormatWithAmPm(widget.meal.mealTime),
                style: AppTextStyles.textR12.copyWith(
                  color: AppColors.gray500,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            BottomSheetRowButtonWidget(
                              title: '수정하기',
                              icon: Icons.edit,
                              onTap: () {},
                            ),
                            BottomSheetRowButtonWidget(
                              title: '삭제하기',
                              icon: Icons.delete,
                              color: AppColors.red,
                              onTap: () {
                                viewModel.deleteMeal(
                                  mealId: widget.meal.id,
                                  imageUrl: widget.meal.imageUrl,
                                );
                                context.pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: const Icon(
                  Icons.more_vert_outlined,
                  color: AppColors.gray600,
                  size: 20,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14, bottom: 2),
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.gray100,
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.network(
                widget.meal.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) =>
                    const Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: AppColors.gray500,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: AppColors.deepMain,
                  ),
                ),
                child: Text(
                  widget.categoryNames
                      .firstWhere(
                        (FoodCategoryModel category) =>
                            category.id == widget.meal.foods.first.categoryId,
                        orElse: () => FoodCategoryModel(
                          id: '',
                          name: '알 수 없음',
                          createdAt: DateTime.now(),
                        ),
                      )
                      .name,
                  style: AppTextStyles.textSb14.copyWith(
                    color: AppColors.deepMain,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                widget.meal.foods.first.name,
                style: AppTextStyles.textR14.copyWith(
                  color: AppColors.gray700,
                ),
              ),
              if (widget.meal.foods.length > 1)
                Expanded(
                  child: GestureDetector(
                    onTap: _toggleExpanded,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Text(
                            '(${widget.meal.foods.length})',
                            style: AppTextStyles.textR14.copyWith(
                              color: AppColors.deepMain,
                            ),
                          ),
                        ),
                        AnimatedRotation(
                          turns: _expanded ? 0.5 : 0.0,
                          duration: const Duration(milliseconds: 200),
                          child: const Icon(
                            Icons.arrow_drop_down_outlined,
                            color: AppColors.gray600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: _expanded
                ? Column(
                    children: widget.meal.foods
                        .skip(1)
                        .map(
                          (FoodModel food) => Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: _buildAdditionalMenuRow(
                              widget.categoryNames
                                  .firstWhere(
                                    (FoodCategoryModel category) =>
                                        category.id == food.categoryId,
                                  )
                                  .name,
                              food.name,
                            ),
                          ),
                        )
                        .toList(),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  // 추가: 아코디언 내부에 사용할 Row 위젯 빌더
  Widget _buildAdditionalMenuRow(String categoryName, String foodName) => Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: AppColors.deepMain,
              ),
            ),
            child: Text(
              categoryName,
              style: AppTextStyles.textSb14.copyWith(
                color: AppColors.deepMain,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            foodName,
            style: AppTextStyles.textR14.copyWith(
              color: AppColors.gray700,
            ),
          ),
        ],
      );
}
