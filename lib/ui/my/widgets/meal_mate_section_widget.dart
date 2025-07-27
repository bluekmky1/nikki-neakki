import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../../util/date_time_formatter.dart';

class MealMateSectionWidget extends StatelessWidget {
  final bool isConnected;
  final String? partnerNickname;
  final String? coupleCode;
  final DateTime? expiryDate;
  final VoidCallback? onCopyCode;
  final VoidCallback? onGenerateNewCode;
  final VoidCallback? onEnterCode;
  final VoidCallback? onMore;

  const MealMateSectionWidget({
    required this.isConnected,
    super.key,
    this.partnerNickname,
    this.coupleCode,
    this.expiryDate,
    this.onCopyCode,
    this.onGenerateNewCode,
    this.onEnterCode,
    this.onMore,
  });

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: AppColors.gray200,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: isConnected
              ? MealMateConnectedWidget(
                  partnerNickname: partnerNickname ?? '식사 메이트',
                  onMore: onMore,
                )
              : MealMateDisconnectedWidget(
                  coupleCode: coupleCode ?? '',
                  expiryDate: expiryDate,
                  onCopyCode: onCopyCode,
                  onGenerateNewCode: onGenerateNewCode,
                  onEnterCode: onEnterCode,
                ),
        ),
      );
}

class MealMateDisconnectedWidget extends StatelessWidget {
  final String coupleCode;
  final DateTime? expiryDate;
  final VoidCallback? onCopyCode;
  final VoidCallback? onGenerateNewCode;
  final VoidCallback? onEnterCode;

  const MealMateDisconnectedWidget({
    required this.coupleCode,
    super.key,
    this.expiryDate,
    this.onCopyCode,
    this.onGenerateNewCode,
    this.onEnterCode,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            '식사 메이트',
            style: AppTextStyles.textB16,
          ),
          const SizedBox(height: 12),
          Text(
            coupleCode.isEmpty
                ? '코드를 생성해서 친구에게 공유해서 함께 식사 기록을 시작해보세요'
                : '아래 코드를 친구에게 공유해서 함께 식사 기록을 시작해보세요',
            style: AppTextStyles.textR14,
          ),
          const SizedBox(height: 16),
          if (coupleCode.isEmpty)
            Row(
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.deepMain,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: onGenerateNewCode,
                    child: const Text(
                      '코드 생성',
                      style: AppTextStyles.textM14,
                    ),
                  ),
                ),
              ],
            ),
          if (coupleCode.isNotEmpty)
            Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.gray100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.gray200),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          coupleCode,
                          style: AppTextStyles.textM18,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        onPressed: onCopyCode,
                        icon: const Icon(
                          Icons.content_copy,
                          color: AppColors.deepMain,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.schedule,
                      size: 16,
                      color: AppColors.gray500,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      DateTimeFormatter.formatExpiryDate(expiryDate),
                      style: AppTextStyles.textR12.copyWith(
                        color: AppColors.gray500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.deepMain,
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: onEnterCode,
                        child: const Text(
                          '코드 입력',
                          style: AppTextStyles.textM14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
        ],
      );
}

class MealMateConnectedWidget extends StatelessWidget {
  final String partnerNickname;
  final VoidCallback? onMore;

  const MealMateConnectedWidget({
    required this.partnerNickname,
    super.key,
    this.onMore,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Text(
                '식사 메이트',
                style: AppTextStyles.textB16,
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.main.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.main,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '연결됨',
                      style: AppTextStyles.textM12.copyWith(
                        color: AppColors.deepMain,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.gray200),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        partnerNickname,
                        style: AppTextStyles.textB16,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '2025.01.21 연결됨',
                        style: AppTextStyles.textR12.copyWith(
                          color: AppColors.gray500,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                      onPressed: onMore,
                      icon: const Icon(Icons.more_vert),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      );
}
