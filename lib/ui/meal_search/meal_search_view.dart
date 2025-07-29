import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/loading_status.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../common/widgets/bottom_navigation_bar_widget.dart';
import 'meal_search_state.dart';
import 'meal_search_view_model.dart';

class MealSearchView extends ConsumerStatefulWidget {
  const MealSearchView({super.key});

  @override
  ConsumerState<MealSearchView> createState() => _MealSearchViewState();
}

class _MealSearchViewState extends ConsumerState<MealSearchView> {
  final TextEditingController _searchKeywordController =
      TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _searchKeywordController.addListener(() {
      if (_searchKeywordController.text.isEmpty) {
        ref.read(mealSearchViewModelProvider.notifier).clearSearchKeyword();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(mealSearchViewModelProvider.notifier)
          .getMealsListWithPagination();
    });
  }

  @override
  void dispose() {
    _searchKeywordController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final MealSearchState state = ref.read(mealSearchViewModelProvider);
      if (state.hasNextPage &&
          state.getMealsLoadingStatus != LoadingStatus.loading) {
        ref
            .read(mealSearchViewModelProvider.notifier)
            .getMealsListWithPagination();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final MealSearchState state = ref.watch(mealSearchViewModelProvider);
    return Scaffold(
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            title: const Text(
              '식사 검색',
              style: AppTextStyles.textSb22,
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  context.pushNamed(Routes.foodsSetting.name);
                },
                icon: const Icon(
                  Icons.local_offer,
                  size: 24,
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 4, 10, 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _searchKeywordController,
                      onTapOutside: (PointerDownEvent? event) {
                        FocusScope.of(context).unfocus();
                      },
                      onChanged: (String value) {
                        setState(() {});
                      },
                      cursorHeight: 20,
                      decoration: InputDecoration(
                        fillColor: AppColors.white,
                        filled: true,
                        hintText: '검색',
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            if (_searchKeywordController.text.isNotEmpty)
                              IconButton(
                                style: IconButton.styleFrom(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                  _searchKeywordController.clear();
                                  ref
                                      .read(
                                          mealSearchViewModelProvider.notifier)
                                      .clearSearchKeyword();
                                },
                                icon: const Icon(
                                  Icons.cancel,
                                  size: 16,
                                ),
                              ),
                            IconButton(
                              style: IconButton.styleFrom(),
                              onPressed: () {
                                if (_searchKeywordController.text.isEmpty) {
                                  return;
                                }
                                ref
                                    .read(mealSearchViewModelProvider.notifier)
                                    .searchMeal(
                                        searchKeyword:
                                            _searchKeywordController.text);
                              },
                              icon: const Icon(
                                Icons.search,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppColors.gray300,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppColors.gray300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppColors.gray300,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (state.isSearched && state.searchMealList.isEmpty)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '검색 결과가 없습니다.',
                      style: AppTextStyles.textR16,
                    ),
                  ],
                ),
              ),
            )
          else
            SliverGrid.count(
              crossAxisCount: 3,
              mainAxisSpacing: 3,
              crossAxisSpacing: 3,
              children: state.isSearched
                  ? List<Widget>.generate(
                      state.searchMealList.length,
                      (int index) => GestureDetector(
                        onTap: () {
                          context.pushNamed(Routes.mealDetail.name,
                              pathParameters: <String, String>{
                                'mealId': state.searchMealList[index].id,
                              });
                        },
                        child: ColoredBox(
                          color: AppColors.gray300,
                          child: Image.network(
                            state.searchMealList[index].imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : List<Widget>.generate(
                      state.mealList.length,
                      (int index) => GestureDetector(
                        onTap: () {
                          context.pushNamed(Routes.mealDetail.name,
                              pathParameters: <String, String>{
                                'mealId': state.mealList[index].id,
                              });
                        },
                        child: ColoredBox(
                          color: AppColors.gray300,
                          child: Image.network(
                            state.mealList[index].imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
            ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 16,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentRouteName: Routes.mealSearch.name,
      ),
    );
  }
}
