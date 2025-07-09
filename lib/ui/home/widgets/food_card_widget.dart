import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class FoodCardWidget extends StatelessWidget {
  const FoodCardWidget({
    required this.title,
    required this.description,
    super.key,
  });

  final String title;
  final String description;

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
                    title,
                    style: AppTextStyles.textB16.copyWith(
                      color: AppColors.gray900,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '07.09 PM 3:00',
                    style: AppTextStyles.textR12.copyWith(
                      color: AppColors.gray500,
                    ),
                  )
                ],
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
                      '파스타',
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
            ],
          ),
        ),
      );
}
