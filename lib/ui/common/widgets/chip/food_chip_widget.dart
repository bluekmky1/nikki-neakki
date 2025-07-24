import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';

class FoodChipWidget extends StatelessWidget {
  const FoodChipWidget({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
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
              title,
              style: AppTextStyles.textSb14.copyWith(
                color: AppColors.deepMain,
              ),
            ),
          ),
        ],
      );
}
