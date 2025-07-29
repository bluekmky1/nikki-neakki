import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/app_colors.dart';
import '../home_state.dart';
import '../home_view_model.dart';
import 'meal_list_widget.dart';
import 'no_partner_widget.dart';

class MealListSectionWidget extends ConsumerWidget {
  const MealListSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeState state = ref.watch(homeViewModelProvider);

    if (state.isMealLoading) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: CircularProgressIndicator(
              color: AppColors.deepMain,
            ),
          ),
        ),
      );
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            if (state.hasPartner || state.selectedTabIndex == 0)
              const MealListWidget()
            else
              const NoPartnerWidget(),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
