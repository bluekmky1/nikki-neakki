import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../theme/app_colors.dart';
import '../../../../../theme/app_text_styles.dart';

class ConfirmDialogWidget extends StatelessWidget {
  const ConfirmDialogWidget({
    required this.onConfirm,
    required this.title,
    required this.confirmText,
    this.description,
    super.key,
  });

  final VoidCallback onConfirm;
  final String title;
  final String? description;
  final String confirmText;

  @override
  Widget build(BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 24,
                ),
                child: Text(
                  title,
                  style: AppTextStyles.textSb18.copyWith(
                    color: AppColors.gray900,
                  ),
                ),
              ),
              if (description != null)
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                  ),
                  child: Text(
                    description!,
                    style: AppTextStyles.textR16.copyWith(
                      color: AppColors.gray700,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.gray900,
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                        ),
                        onPressed: () {
                          context.pop();
                        },
                        child: Text(
                          '취소',
                          style: AppTextStyles.textR16.copyWith(
                            color: AppColors.gray900,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.main,
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                        ),
                        onPressed: onConfirm,
                        child: Text(
                          confirmText,
                          style: AppTextStyles.textButton5.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
