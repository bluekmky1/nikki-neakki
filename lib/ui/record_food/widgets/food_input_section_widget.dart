import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class FoodInputSectionWidget extends StatelessWidget {
  final String selectedFoodCategory;
  final TextEditingController foodNameController;
  final VoidCallback? onCategoryTap;
  final VoidCallback? onAddFoodTap;

  const FoodInputSectionWidget({
    required this.selectedFoodCategory,
    required this.foodNameController,
    super.key,
    this.onCategoryTap,
    this.onAddFoodTap,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: onCategoryTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      border: Border.all(
                        color: selectedFoodCategory.isEmpty
                            ? AppColors.gray400
                            : AppColors.deepMain,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      selectedFoodCategory.isEmpty
                          ? '카테고리'
                          : selectedFoodCategory,
                      style: AppTextStyles.textR14.copyWith(
                        color: selectedFoodCategory.isEmpty
                            ? AppColors.gray600
                            : AppColors.deepMain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: foodNameController,
                    onTapOutside: (PointerDownEvent event) =>
                        FocusScope.of(context).unfocus(),
                    style: AppTextStyles.textR14.copyWith(
                      color: AppColors.gray900,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      hintText: '추가할 음식 이름',
                      hintStyle: AppTextStyles.textR14.copyWith(
                        color: AppColors.gray600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  style: IconButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.zero,
                    iconSize: 24,
                  ),
                  onPressed: onAddFoodTap,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          const Divider(
            color: AppColors.gray400,
            height: 1,
          ),
          const SizedBox(height: 12),
        ],
      );
}
