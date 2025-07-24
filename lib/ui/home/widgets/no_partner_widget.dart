import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class NoPartnerWidget extends StatelessWidget {
  const NoPartnerWidget({super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.gray200,
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.main.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_add_rounded,
                color: AppColors.main,
                size: 36,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '아직 식사 메이트가 없어요',
              style: AppTextStyles.textB18,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '메이트와 함께 식사를 기록하고\n서로의 식단을 공유해보세요',
              style: AppTextStyles.textR14.copyWith(
                color: AppColors.gray600,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.main,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  context.pushNamed(Routes.myPage.name);
                },
                child: const Text(
                  '식사 메이트 연결하기',
                  style: AppTextStyles.textSb16,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.gray600,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                _showConnectInfoDialog(context);
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '연결 방법 알아보기',
                    style: AppTextStyles.textM14,
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.help_outline,
                    size: 16,
                    color: AppColors.gray600,
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  void _showConnectInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          '식사 메이트 연결 방법',
          style: AppTextStyles.textB20,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildStepItem(
              step: '1',
              title: '마이페이지로 이동',
              description: '하단 네비게이션에서 마이페이지를 선택해주세요',
            ),
            const SizedBox(height: 16),
            _buildStepItem(
              step: '2',
              title: '연결 코드 생성',
              description: '식사 메이트 섹션에서 내 코드를 확인하세요',
            ),
            const SizedBox(height: 16),
            _buildStepItem(
              step: '3',
              title: '코드 공유',
              description: '친구에게 코드를 공유하거나 친구 코드를 입력하세요',
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              '닫기',
              style: AppTextStyles.textM14.copyWith(
                color: AppColors.gray600,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.main,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              context
                ..pop()
                ..pushNamed(Routes.myPage.name);
            },
            child: const Text(
              '바로 가기',
              style: AppTextStyles.textM14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem({
    required String step,
    required String title,
    required String description,
  }) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: AppColors.main,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step,
                style: AppTextStyles.textB14.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: AppTextStyles.textSb14,
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: AppTextStyles.textR14.copyWith(
                    color: AppColors.gray600,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
