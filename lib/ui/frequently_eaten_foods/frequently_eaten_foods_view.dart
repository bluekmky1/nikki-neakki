import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../common/widgets/bottom_navigation_bar_widget.dart';

class FrequentlyEatenFoodsView extends ConsumerStatefulWidget {
  const FrequentlyEatenFoodsView({super.key});

  @override
  ConsumerState<FrequentlyEatenFoodsView> createState() =>
      _FrequentlyEatenFoodsViewState();
}

class _FrequentlyEatenFoodsViewState
    extends ConsumerState<FrequentlyEatenFoodsView> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            '자주 먹는 음식',
            style: AppTextStyles.textSb22,
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                context.pushNamed(Routes.frequentlyEatenFoodsSetting.name);
              },
              icon: const Icon(
                Icons.settings_outlined,
                color: AppColors.gray900,
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: AppColors.deepMain,
                              ),
                            ),
                            child: Text(
                              '파스타',
                              style: AppTextStyles.textSb16.copyWith(
                                color: AppColors.deepMain,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '(10)',
                            style: AppTextStyles.textR14.copyWith(
                              color: AppColors.gray500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: List<Widget>.generate(
                            10,
                            (int index) => Container(
                              margin: const EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.white,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: AppColors.gray500
                                        .withValues(alpha: 0.2),
                                    blurRadius: 2,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              width: 320,
                              height: 230,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '알리오 올리오',
                                      style: AppTextStyles.textSb14.copyWith(
                                        color: AppColors.gray900,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Expanded(
                                      child: Container(
                                        width: 300,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: AppColors.gray200,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBarWidget(
          currentRouteName: Routes.frequentlyEatenFoods.name,
        ),
      );
}
