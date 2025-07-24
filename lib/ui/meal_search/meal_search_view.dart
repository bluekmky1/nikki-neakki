import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../common/widgets/bottom_navigation_bar_widget.dart';

class MealSearchView extends ConsumerStatefulWidget {
  const MealSearchView({super.key});

  @override
  ConsumerState<MealSearchView> createState() => _MealSearchViewState();
}

class _MealSearchViewState extends ConsumerState<MealSearchView> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
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
                        onTapOutside: (PointerDownEvent? event) {
                          FocusScope.of(context).unfocus();
                        },
                        cursorHeight: 20,
                        decoration: InputDecoration(
                          fillColor: AppColors.white,
                          filled: true,
                          hintText: '검색',
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.search,
                              size: 24,
                            ),
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
            SliverGrid.count(
              crossAxisCount: 3,
              mainAxisSpacing: 3,
              crossAxisSpacing: 3,
              children: List<Widget>.generate(
                30,
                (int index) => GestureDetector(
                  onTap: () {
                    context.pushNamed(Routes.mealDetail.name,
                        pathParameters: <String, String>{
                          'mealId': '1',
                        });
                  },
                  child: Container(
                    color: AppColors.gray300,
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
