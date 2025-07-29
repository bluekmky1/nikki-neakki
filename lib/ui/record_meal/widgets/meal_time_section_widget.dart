import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class MealTimeSectionWidget extends StatelessWidget {
  final String mealTime;
  final DateTime initialDateTime;
  final VoidCallback? onTimeSettingTap;
  final void Function(DateTime) onTimeChanged;

  const MealTimeSectionWidget({
    required this.mealTime,
    required this.initialDateTime,
    required this.onTimeChanged,
    super.key,
    this.onTimeSettingTap,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: <Widget>[
            Text(
              '식사 시간 :',
              style: AppTextStyles.textSb18.copyWith(
                color: AppColors.gray900,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              mealTime,
              style: AppTextStyles.textR18.copyWith(
                color: AppColors.gray900,
              ),
            ),
            const Spacer(),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.deepMain,
                textStyle: AppTextStyles.textR18.copyWith(
                  color: AppColors.deepMain,
                ),
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) => SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                '식사 시간',
                                style: AppTextStyles.textSb22.copyWith(
                                  color: AppColors.gray900,
                                ),
                              ),
                              const Spacer(),
                              const CloseButton(),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 200,
                            child: CupertinoTheme(
                              data: CupertinoThemeData(
                                textTheme: CupertinoTextThemeData(
                                  dateTimePickerTextStyle:
                                      AppTextStyles.textR16.copyWith(
                                    fontSize: 28,
                                    color: AppColors.gray900,
                                  ),
                                ),
                              ),
                              child: CupertinoDatePicker(
                                initialDateTime: initialDateTime,
                                selectionOverlayBuilder: (BuildContext context,
                                        {required int columnCount,
                                        required int selectedIndex}) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                mode: CupertinoDatePickerMode.time,
                                onDateTimeChanged: onTimeChanged,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: onTimeSettingTap,
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.main,
                              foregroundColor: AppColors.white,
                              textStyle: AppTextStyles.textSb18.copyWith(
                                color: AppColors.white,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('설정'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: const Text('설정'),
            ),
          ],
        ),
      );
}
