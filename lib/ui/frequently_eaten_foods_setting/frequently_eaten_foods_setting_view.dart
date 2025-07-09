import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class FrequentlyEatenFoodsSettingView extends ConsumerStatefulWidget {
  const FrequentlyEatenFoodsSettingView({super.key});

  @override
  ConsumerState<FrequentlyEatenFoodsSettingView> createState() =>
      _FrequentlyEatenFoodsSettingViewState();
}

class _FrequentlyEatenFoodsSettingViewState
    extends ConsumerState<FrequentlyEatenFoodsSettingView> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            '음식 태그 관리',
            style: AppTextStyles.textSb18,
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                size: 28,
                color: AppColors.gray900,
              ),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  ...List<Widget>.generate(
                    10,
                    (int index) => MenuBlock(
                      title: '${'아' * (index + 1)}침',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

class MenuBlock extends StatelessWidget {
  const MenuBlock({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) => TextButton(
        style: TextButton.styleFrom(
          textStyle: AppTextStyles.textSb16.copyWith(
            color: AppColors.deepMain,
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          foregroundColor: AppColors.deepMain,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: const BorderSide(
              color: AppColors.deepMain,
            ),
          ),
        ),
        onPressed: () {},
        child: Text(
          title,
          style: AppTextStyles.textSb16.copyWith(
            color: AppColors.deepMain,
          ),
        ),
      );
}
