import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/loading_status.dart';
import '../../domain/meal/model/food_model.dart';
import '../../domain/meal/model/meal_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../util/date_time_formatter.dart';
import '../common/widgets/button/bottom_sheet_row_button_widget.dart';
import '../common/widgets/chip/food_chip_widget.dart';
import 'meal_detail_state.dart';
import 'meal_detail_view_model.dart';

class MealDetailView extends ConsumerStatefulWidget {
  const MealDetailView({
    required this.mealId,
    super.key,
  });

  final String mealId;

  @override
  ConsumerState<MealDetailView> createState() => _MealDetailViewState();
}

class _MealDetailViewState extends ConsumerState<MealDetailView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(mealDetailViewModelProvider.notifier).loadMealDetail(
            mealId: widget.mealId,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final MealDetailState state = ref.watch(mealDetailViewModelProvider);

    if (state.loadingStatus == LoadingStatus.loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state.meal == null) {
      return const Scaffold(
        body: Center(
          child: Text('식사 정보를 불러올 수 없습니다.'),
        ),
      );
    }

    final MealModel meal = state.meal!;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            BottomSheetRowButtonWidget(
                              icon: Icons.edit,
                              title: '수정하기',
                              onTap: () {},
                            ),
                            BottomSheetRowButtonWidget(
                              icon: Icons.delete,
                              title: '삭제하기',
                              color: AppColors.red,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 식사 기본 정보
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: AppColors.gray200,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              meal.mealType.name,
                              style: AppTextStyles.textSb18.copyWith(
                                color: AppColors.gray900,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              DateTimeFormatter.yearMonthDayFormat(
                                  meal.mealTime),
                              style: AppTextStyles.textR14.copyWith(
                                color: AppColors.gray600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (meal.imageUrl.isNotEmpty)
                          Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(meal.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        else
                          Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              color: AppColors.gray100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Icon(
                                  Icons.image_not_supported_outlined,
                                  size: 48,
                                  color: AppColors.gray400,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '사진이 없습니다',
                                  style: AppTextStyles.textR14.copyWith(
                                    color: AppColors.gray600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Row(
                          children: <Widget>[
                            const SizedBox(width: 8),
                            const Spacer(),
                            if (!state.isMyMeal)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.main.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  state.partnerNickname,
                                  style: AppTextStyles.textR12.copyWith(
                                    color: AppColors.main,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 식사 사진

                  // 음식 목록
                  Text(
                    '음식 목록',
                    style: AppTextStyles.textSb18.copyWith(
                      color: AppColors.gray900,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (meal.foods.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: AppColors.gray100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: <Widget>[
                          const Icon(
                            Icons.restaurant_outlined,
                            size: 48,
                            color: AppColors.gray400,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '등록된 음식이 없습니다',
                            style: AppTextStyles.textR14.copyWith(
                              color: AppColors.gray600,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: meal.foods
                          .map((FoodModel food) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: AppColors.gray200),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      FoodChipWidget(
                                        title: food.categoryName,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          food.name,
                                          style: AppTextStyles.textR16.copyWith(
                                            color: AppColors.gray900,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                    ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
