import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../common/widgets/button/bottom_sheet_row_button_widget.dart';
import '../common/widgets/button/filled_text_button_widget.dart';

class FoodsSettingView extends ConsumerStatefulWidget {
  const FoodsSettingView({super.key});

  @override
  ConsumerState<FoodsSettingView> createState() => _FoodsSettingViewState();
}

class _FoodsSettingViewState extends ConsumerState<FoodsSettingView> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            '음식 태그 관리',
            style: AppTextStyles.textSb22,
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useRootNavigator: true, // 루트에서 띄우기
                  builder: (BuildContext context) => SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                        bottom: MediaQuery.of(context).viewInsets.bottom +
                            16, // ★ 이 부분!
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '태그 추가하기',
                                  style: AppTextStyles.textSb18,
                                ),
                                CloseButton(),
                              ],
                            ),
                            const TextField(
                              decoration: InputDecoration(
                                hintText: '새로운 태그 이름',
                              ),
                            ),
                            const SizedBox(height: 16),
                            FilledTextButtonWidget(
                              title: '추가',
                              isEnabled: true,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
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
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useRootNavigator: true, // 루트에서 띄우기
            builder: (BuildContext context) => SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    BottomSheetRowButtonWidget(
                      title: '수정하기',
                      icon: Icons.edit,
                      onTap: () {},
                    ),
                    BottomSheetRowButtonWidget(
                      title: '삭제하기',
                      icon: Icons.delete,
                      color: AppColors.red,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: Text(
          title,
          style: AppTextStyles.textSb16.copyWith(
            color: AppColors.deepMain,
          ),
        ),
      );
}
