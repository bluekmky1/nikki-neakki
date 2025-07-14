import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import 'record_food_state.dart';
import 'record_food_view_model.dart';

class RecordFoodView extends StatefulWidget {
  const RecordFoodView({super.key});

  @override
  State<RecordFoodView> createState() => _RecordFoodViewState();
}

class _RecordFoodViewState extends State<RecordFoodView> {
  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: true,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text(
                '음식 기록',
                style: AppTextStyles.textSb22.copyWith(
                  color: AppColors.gray900,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  // 음식 이미지
                  Container(
                    width: double.infinity,
                    height: 200,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.gray300,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  // 음식 태그와 리스트 추가 버튼
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              enableDrag: false,
                              builder: (BuildContext context) =>
                                  const CategorySelectBottomSheetWidget(),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.gray100,
                              border: Border.all(
                                color: AppColors.gray400,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '카테고리',
                              style: AppTextStyles.textR14.copyWith(
                                color: AppColors.gray600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            onTapOutside: (PointerDownEvent event) =>
                                FocusScope.of(context).unfocus(),
                            style: AppTextStyles.textR14.copyWith(
                              color: AppColors.gray900,
                            ),
                            decoration: InputDecoration(
                              hintText: '음식 이름',
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
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.gray900,
                                content: Text(
                                  '음식 이름을 입력해주세요.',
                                  style: AppTextStyles.textR14.copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.gray100,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: AppColors.deepMain,
                        ),
                      ),
                      child: Text(
                        '파스타',
                        style: AppTextStyles.textR14.copyWith(
                          color: AppColors.deepMain,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Text(
                        '알리오 올리오',
                        style: AppTextStyles.textR14.copyWith(
                          color: AppColors.gray900,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: EdgeInsets.zero,
                        iconSize: 24,
                      ),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.gray100,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: AppColors.deepMain,
                        ),
                      ),
                      child: Text(
                        '파스타',
                        style: AppTextStyles.textR14.copyWith(
                          color: AppColors.deepMain,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Text(
                        '알리오 올리오',
                        style: AppTextStyles.textR14.copyWith(
                          color: AppColors.gray900,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: EdgeInsets.zero,
                        iconSize: 24,
                      ),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}

class CategorySelectBottomSheetWidget extends ConsumerWidget {
  const CategorySelectBottomSheetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final RecordFoodState state = ref.watch(recordFoodViewModelProvider);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '카테고리 선택',
                style: AppTextStyles.textSb18.copyWith(
                  color: AppColors.gray900,
                ),
              ),
              CloseButton(
                color: AppColors.gray900,
                style: IconButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  iconSize: 24,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 카테고리 추가
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  onTapOutside: (PointerDownEvent event) =>
                      FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    hintText: '카테고리 검색',
                    suffixIcon: IconButton(
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        foregroundColor: AppColors.gray600,
                      ),
                      icon: const Icon(Icons.search),
                    ),
                    hintStyle: AppTextStyles.textR14.copyWith(
                      color: AppColors.gray600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (state.foodCategories.isEmpty)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text: '피자',
                          style: AppTextStyles.textR16.copyWith(
                            color: AppColors.deepMain,
                          ),
                        ),
                        TextSpan(
                          text: '로 검색된 카테고리가 없습니다.',
                          style: AppTextStyles.textR16.copyWith(
                            color: AppColors.gray600,
                          ),
                        ),
                      ],
                    ),
                    style: AppTextStyles.textR14.copyWith(
                      color: AppColors.gray600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.deepMain,
                      textStyle: AppTextStyles.textR16.copyWith(
                        color: AppColors.deepMain,
                      ),
                    ),
                    child: Text(
                      '카테고리에 추가',
                      style: AppTextStyles.textR14.copyWith(
                        color: AppColors.deepMain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: state.foodCategories.length,
                itemBuilder: (BuildContext context, int index) => TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.deepMain,
                    textStyle: AppTextStyles.textR16.copyWith(
                      color: AppColors.deepMain,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                  ),
                  onPressed: () {
                    context.pop();
                  },
                  child: Row(
                    children: <Widget>[
                      Text(state.foodCategories[index]),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
