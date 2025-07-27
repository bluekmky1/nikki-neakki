import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../util/date_time_formatter.dart';
import '../../util/text_utils.dart';
import '../common/widgets/button/filled_text_button_widget.dart';
import 'record_food_state.dart';
import 'record_food_view_model.dart';
import 'widgets/food_input_section_widget.dart';
import 'widgets/food_list_section_widget.dart';
import 'widgets/image_picker_widget.dart';
import 'widgets/meal_time_section_widget.dart';

class RecordFoodView extends ConsumerStatefulWidget {
  const RecordFoodView({
    required this.mealType,
    super.key,
  });

  final String mealType;

  @override
  ConsumerState<RecordFoodView> createState() => _RecordFoodViewState();
}

class _RecordFoodViewState extends ConsumerState<RecordFoodView> {
  final TextEditingController _editingFoodNameController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(recordFoodViewModelProvider.notifier)
          .init(mealType: widget.mealType);
    });
  }

  @override
  Widget build(BuildContext context) {
    final RecordFoodState state = ref.watch(recordFoodViewModelProvider);
    final RecordFoodViewModel viewModel =
        ref.read(recordFoodViewModelProvider.notifier);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              '${widget.mealType} 기록',
              style: AppTextStyles.textSb22.copyWith(
                color: AppColors.gray900,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MealTimeSectionWidget(
                  mealTime: DateTimeFormatter.timeFormatWithAmPm(
                    state.initialMealTime,
                  ),
                  initialDateTime: state.initialMealTime,
                  onTimeSettingTap: () {
                    viewModel.onConfirmMealTime(
                      mealTime: ref.read(recordFoodViewModelProvider).mealTime,
                    );
                    context.pop();
                  },
                  onTimeChanged: (DateTime dateTime) {
                    viewModel.onChangeMealTime(mealTime: dateTime);
                  },
                ),
                ImagePickerWidget(
                  pickedImage: state.pickedImage,
                  onCameraTap: () async {
                    await viewModel.pickImageFromCamera();
                    if (context.mounted) {
                      context.pop();
                    }
                  },
                  onGalleryTap: () async {
                    await viewModel.pickImage();
                    if (context.mounted) {
                      context.pop();
                    }
                  },
                  onDeleteTap: () {
                    viewModel.deleteImage();
                    if (context.mounted) {
                      context.pop();
                    }
                  },
                ),
                FoodInputSectionWidget(
                  selectedFoodCategory: state.selectedFoodCategoryName,
                  foodNameController: _editingFoodNameController,
                  onCategoryTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      enableDrag: false,
                      builder: (BuildContext context) => SizedBox(
                          height: MediaQuery.of(context).size.height * 0.65,
                          child: const CategorySelectBottomSheetWidget()),
                    );
                  },
                  onAddFoodTap: () {
                    if (state.selectedFoodCategoryId.isEmpty) {
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
                      setState(() {});
                    }
                  },
                ),
              ],
            ),
          ),
          FoodListSectionWidget(
            foods: state.foods,
            onDeleteFood: (int index) {
              viewModel.deleteFood(foodIndex: index);
            },
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            16,
            16,
            16,
            0,
          ),
          child: FilledTextButtonWidget(
            title: '저장',
            isEnabled: state.canSave,
            onPressed: () {},
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
                '음식 태그 추가',
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
                    hintText: '태그 검색',
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
                  if (state.searchKeyword.trim().isNotEmpty)
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
                                '''${TextUtils.getPostposition(state.searchKeyword)}\n검색된 태그가 없습니다.''',
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
                    )
                  else
                    Text(
                      '등록된 태그가 없습니다.',
                      style: AppTextStyles.textR16.copyWith(
                        color: AppColors.gray600,
                      ),
                    ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      if (state.searchKeyword.trim().isEmpty) {
                        return;
                      }
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
                      '태그 추가하기',
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
                          categoryId: state.searchedFoodCategories[index].id,
                          categoryName:
                              state.searchedFoodCategories[index].name,
                        );
                        context.pop();
                      },
                      child: Row(
                        children: <Widget>[
                          Text(state.searchedFoodCategories[index].name),
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
