import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../util/text_utils.dart';
import 'record_food_state.dart';
import 'record_food_view_model.dart';

class RecordFoodView extends ConsumerStatefulWidget {
  const RecordFoodView({super.key});

  @override
  ConsumerState<RecordFoodView> createState() => _RecordFoodViewState();
}

class _RecordFoodViewState extends ConsumerState<RecordFoodView> {
  final TextEditingController _editingFoodNameController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final RecordFoodState state = ref.watch(recordFoodViewModelProvider);
    final RecordFoodViewModel viewModel =
        ref.watch(recordFoodViewModelProvider.notifier);
    return Scaffold(
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
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.gray300,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 24,
                        color: AppColors.gray600,
                      ),
                    ),
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
                            isScrollControlled: true,
                            enableDrag: false,
                            builder: (BuildContext context) => SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.65,
                                child: const CategorySelectBottomSheetWidget()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.gray100,
                            border: Border.all(
                              color: state.selectedFoodCategory.isEmpty
                                  ? AppColors.gray400
                                  : AppColors.deepMain,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            state.selectedFoodCategory.isEmpty
                                ? '카테고리'
                                : state.selectedFoodCategory,
                            style: AppTextStyles.textR14.copyWith(
                              color: state.selectedFoodCategory.isEmpty
                                  ? AppColors.gray600
                                  : AppColors.deepMain,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _editingFoodNameController,
                          onTapOutside: (PointerDownEvent event) =>
                              FocusScope.of(context).unfocus(),
                          style: AppTextStyles.textR14.copyWith(
                            color: AppColors.gray900,
                          ),
                          onChanged: (String value) {
                            setState(() {});
                          },
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
                        onPressed: () {
                          if (state.selectedFoodCategory.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 20,
                                ),
                                backgroundColor: AppColors.gray900,
                                content: Text(
                                  '음식 카테고리를 선택해주세요.',
                                  style: AppTextStyles.textR14.copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            return;
                          }
                          if (_editingFoodNameController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 20,
                                ),
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
                            return;
                          } else {
                            viewModel.addFood(
                              foodName: _editingFoodNameController.text,
                            );

                            _editingFoodNameController.clear();
                          }
                        },
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
            ),
          ),
          SliverList.builder(
            itemCount: state.foods.length,
            itemBuilder: (BuildContext context, int index) => Padding(
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
                      state.foods[index].category,
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
                      state.foods[index].name,
                      style: AppTextStyles.textR14.copyWith(
                        color: AppColors.gray900,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    onPressed: () {
                      viewModel.deleteFood(foodIndex: index);
                    },
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
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: TextButton(
            onPressed: state.canSave ? () {} : null,
            style: TextButton.styleFrom(
              backgroundColor:
                  state.canSave ? AppColors.main : AppColors.gray400,
              foregroundColor:
                  state.canSave ? AppColors.white : AppColors.gray600,
              textStyle: AppTextStyles.textSb18.copyWith(
                color: state.canSave ? AppColors.white : AppColors.gray600,
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
                Text('저장'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategorySelectBottomSheetWidget extends ConsumerStatefulWidget {
  const CategorySelectBottomSheetWidget({
    super.key,
  });

  @override
  ConsumerState<CategorySelectBottomSheetWidget> createState() =>
      _CategorySelectBottomSheetWidgetState();
}

class _CategorySelectBottomSheetWidgetState
    extends ConsumerState<CategorySelectBottomSheetWidget> {
  final TextEditingController _searchKeywordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final RecordFoodState state = ref.watch(recordFoodViewModelProvider);
    final RecordFoodViewModel viewModel =
        ref.watch(recordFoodViewModelProvider.notifier);

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
                '음식 카테고리 선택',
                style: AppTextStyles.textSb22.copyWith(
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
                  controller: _searchKeywordController,
                  onTapOutside: (PointerDownEvent event) =>
                      FocusScope.of(context).unfocus(),
                  onChanged: (String value) {
                    viewModel.onSearchFoodCategory(
                      searchKeyword: value,
                    );
                    setState(() {});
                  },
                  maxLength: 10,
                  decoration: InputDecoration(
                    hintText: '카테고리 검색',
                    suffixIcon: IconButton(
                      onPressed: () {
                        viewModel.onSearchFoodCategory(
                          searchKeyword: state.searchKeyword,
                        );
                        setState(() {});
                        FocusScope.of(context).unfocus();
                      },
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

          if (state.searchedFoodCategories.isEmpty)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text: state.searchKeyword,
                          style: AppTextStyles.textR16.copyWith(
                            color: AppColors.deepMain,
                          ),
                        ),
                        TextSpan(
                          text:
                              '''${TextUtils.getPostposition(state.searchKeyword)}\n검색된 카테고리가 없습니다.''',
                          style: AppTextStyles.textR16.copyWith(
                            color: AppColors.gray600,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.textR14.copyWith(
                      color: AppColors.gray600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      viewModel.addToCategory(
                        category: state.searchKeyword,
                      );
                      setState(() {});
                      context.pop();
                    },
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
                itemCount: state.searchedFoodCategories.length,
                itemBuilder: (BuildContext context, int index) => Column(
                  children: <Widget>[
                    TextButton(
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
                        viewModel.onSelectFoodCategory(
                          category: state.searchedFoodCategories[index],
                        );
                        context.pop();
                      },
                      child: Row(
                        children: <Widget>[
                          Text(state.searchedFoodCategories[index]),
                        ],
                      ),
                    ),
                    if (index == state.searchedFoodCategories.length - 1)
                      const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
