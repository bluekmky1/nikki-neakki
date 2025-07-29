import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/loading_status.dart';
import '../../service/category/category_service.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../common/widgets/button/bottom_sheet_row_button_widget.dart';
import '../common/widgets/button/filled_text_button_widget.dart';
import '../common/widgets/dialog/confiram_dialog_widget.dart';
import 'foods_setting_state.dart';
import 'foods_setting_view_model.dart';

class FoodsSettingView extends ConsumerStatefulWidget {
  const FoodsSettingView({super.key});

  @override
  ConsumerState<FoodsSettingView> createState() => _FoodsSettingViewState();
}

class _FoodsSettingViewState extends ConsumerState<FoodsSettingView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(foodsSettingViewModelProvider.notifier).init(
            foodCategories: ref.read(categoryServiceProvider).myFoodCategories,
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FoodsSettingState state = ref.watch(foodsSettingViewModelProvider);

    return Scaffold(
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
                builder: (BuildContext context) =>
                    const CreateFoodBottomSheet(),
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
                  state.foodCategories.length,
                  (int index) => MenuBlock(
                    title: state.foodCategories[index].name,
                    foodCategoryId: state.foodCategories[index].id,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CreateFoodBottomSheet extends ConsumerStatefulWidget {
  const CreateFoodBottomSheet({super.key});

  @override
  ConsumerState<CreateFoodBottomSheet> createState() =>
      _CreateFoodBottomSheetState();
}

class _CreateFoodBottomSheetState extends ConsumerState<CreateFoodBottomSheet> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final FoodsSettingViewModel viewModel =
        ref.read(foodsSettingViewModelProvider.notifier);

    ref.listen(
        foodsSettingViewModelProvider.select(
            (FoodsSettingState state) => state.createFoodCategoryLoadingStatus),
        (LoadingStatus? previous, LoadingStatus next) {
      if (next == LoadingStatus.success) {
        context.pop();
      }
    });
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16, // ★ 이 부분!
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
              TextField(
                controller: _textEditingController,
                maxLength: 10,
                onChanged: (String value) {
                  setState(() {});
                },
                decoration: const InputDecoration(
                  hintText: '새로운 태그 이름',
                ),
              ),
              const SizedBox(height: 16),
              FilledTextButtonWidget(
                title: '추가',
                onPressed: _textEditingController.text.isNotEmpty
                    ? () {
                        viewModel.createFoodCategory(
                          name: _textEditingController.text,
                        );
                      }
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpdateFoodBottomSheet extends ConsumerStatefulWidget {
  const UpdateFoodBottomSheet({
    required this.foodCategoryId,
    required this.foodCategoryName,
    super.key,
  });
  final String foodCategoryId;
  final String foodCategoryName;

  @override
  ConsumerState<UpdateFoodBottomSheet> createState() =>
      _UpdateFoodBottomSheetState();
}

class _UpdateFoodBottomSheetState extends ConsumerState<UpdateFoodBottomSheet> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.foodCategoryName;
  }

  @override
  Widget build(BuildContext context) {
    final FoodsSettingViewModel viewModel =
        ref.read(foodsSettingViewModelProvider.notifier);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16, // ★ 이 부분!
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '태그 수정하기',
                    style: AppTextStyles.textSb18,
                  ),
                  CloseButton(),
                ],
              ),
              TextField(
                controller: _textEditingController,
                maxLength: 10,
                onChanged: (String value) {
                  setState(() {});
                },
                decoration: const InputDecoration(
                  hintText: '태그 이름',
                ),
              ),
              const SizedBox(height: 16),
              FilledTextButtonWidget(
                title: '수정',
                onPressed: _textEditingController.text.isNotEmpty
                    ? () {
                        viewModel.updateFoodCategory(
                          foodCategoryId: widget.foodCategoryId,
                          name: _textEditingController.text,
                        );
                        context
                          ..pop()
                          ..pop();
                      }
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuBlock extends ConsumerWidget {
  const MenuBlock({
    required this.title,
    required this.foodCategoryId,
    super.key,
  });

  final String title;
  final String foodCategoryId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FoodsSettingViewModel viewModel =
        ref.read(foodsSettingViewModelProvider.notifier);

    return TextButton(
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
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        useRootNavigator: true, // 루트에서 띄우기
                        builder: (BuildContext context) =>
                            UpdateFoodBottomSheet(
                          foodCategoryId: foodCategoryId,
                          foodCategoryName: title,
                        ),
                      );
                    },
                  ),
                  BottomSheetRowButtonWidget(
                    title: '삭제하기',
                    icon: Icons.delete,
                    color: AppColors.red,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => ConfirmDialogWidget(
                          onConfirm: () {
                            viewModel.deleteFoodCategory(
                              foodCategoryId: foodCategoryId,
                            );
                            context
                              ..pop()
                              ..pop();
                          },
                          title: '태그 삭제하기',
                          description: '삭제 시, 해당 태그와 관련된 모든 기록이 삭제됩니다.',
                          confirmText: '삭제',
                        ),
                      );
                    },
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
}
