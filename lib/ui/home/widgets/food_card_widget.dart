import 'package:flutter/material.dart';

import '../../../domain/meal/model/food_model.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class FoodCardWidget extends StatefulWidget {
  const FoodCardWidget({
    required this.title,
    required this.foods,
    super.key,
  });

  final String title;
  final List<FoodModel> foods;

  @override
  State<FoodCardWidget> createState() => _FoodCardWidgetState();
}

class _FoodCardWidgetState extends State<FoodCardWidget> {
  bool _expanded = false;

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.gray200,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.gray500.withValues(alpha: 0.2),
              blurRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    widget.title,
                    style: AppTextStyles.textB16.copyWith(
                      color: AppColors.gray900,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '07.09 PM 3:00',
                    style: AppTextStyles.textR12.copyWith(
                      color: AppColors.gray500,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
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
                  height: 160,
                  decoration: BoxDecoration(
                    color: AppColors.gray100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: AppColors.deepMain,
                      ),
                    ),
                    child: Text(
                      widget.foods.first.category,
                      style: AppTextStyles.textSb14.copyWith(
                        color: AppColors.deepMain,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.foods.first.name,
                    style: AppTextStyles.textR14.copyWith(
                      color: AppColors.gray700,
                    ),
                  ),
                  if (widget.foods.length > 1)
                    Expanded(
                      child: GestureDetector(
                        onTap: _toggleExpanded,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Text(
                                '(${widget.foods.length})',
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
                        children: <Widget>[
                          const SizedBox(height: 8),
                          _buildAdditionalMenuRow('샐러드', '신선한 야채 샐러드', 0),
                          const SizedBox(height: 8),
                          _buildAdditionalMenuRow('스테이크', '부드러운 소고기 스테이크', 1),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      );

  // 추가: 아코디언 내부에 사용할 Row 위젯 빌더
  Widget _buildAdditionalMenuRow(
          String foodName, String description, int additionalCount) =>
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
              foodName,
              style: AppTextStyles.textSb14.copyWith(
                color: AppColors.deepMain,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            description,
            style: AppTextStyles.textR14.copyWith(
              color: AppColors.gray700,
            ),
          ),
        ],
      );
}
