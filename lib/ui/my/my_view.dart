import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../routes/routes.dart';
import '../../service/supabase/supabase_service.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../common/widgets/bottom_navigation_bar_widget.dart';
import '../common/widgets/button/bottom_sheet_row_button_widget.dart';
import '../common/widgets/button/filled_text_button_widget.dart';
import 'my_state.dart';
import 'my_view_model.dart';
import 'widgets/meal_mate_section_widget.dart';

class MyView extends ConsumerStatefulWidget {
  const MyView({super.key});

  @override
  ConsumerState<MyView> createState() => _MyViewState();
}

class _MyViewState extends ConsumerState<MyView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(myViewModelProvider.notifier).getInvitationCode();
    });
  }

  @override
  Widget build(BuildContext context) {
    final String username = ref.watch(supabaseServiceProvider).username;

    final MyState state = ref.watch(myViewModelProvider);
    final MyViewModel viewModel = ref.read(myViewModelProvider.notifier);

    if (state.isLoading) {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBarWidget(
          currentRouteName: Routes.myPage.name,
        ),
        body: const Center(
          child: CircularProgressIndicator(
            color: AppColors.main,
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            toolbarHeight: 80,
            centerTitle: false,
            title: Text(
              username,
              style: AppTextStyles.textB22,
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            BottomSheetRowButtonWidget(
                                title: '로그아웃',
                                icon: Icons.logout,
                                color: AppColors.red,
                                onTap: () {
                                  context.pop();
                                  viewModel.signOut();
                                }),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: AppColors.gray200,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            '나의 밥 시간',
                            style: AppTextStyles.textB16,
                          ),
                          const SizedBox(height: 12),
                          MealHeatBar(frequency: mealFrequency),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  MealMateSectionWidget(
                    isConnected: state.hasPartner,
                    partnerNickname: state.mealMateUserName,
                    coupleCode: state.mealMateCode,
                    expiryDate: state.mealMateCodeExpiryDate,
                    onCopyCode: () {
                      // 클립보드 복사 로직
                      Clipboard.setData(
                          ClipboardData(text: state.mealMateCode));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: AppColors.gray900,
                          content: Text('코드가 복사되었습니다.'),
                        ),
                      );
                    },
                    onGenerateNewCode: viewModel.createInvitationCode,
                    onEnterCode: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) => const SafeArea(
                          child: EnterCodeBottomSheetWidget(),
                        ),
                      );
                    },
                    onMore: () {
                      // 더보기 다이얼로그
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) => SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                BottomSheetRowButtonWidget(
                                  icon: Icons.link_off,
                                  title: '연결 해제',
                                  color: AppColors.red,
                                  onTap: () {
                                    // 연결 해제 로직
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentRouteName: Routes.myPage.name,
      ),
    );
  }
}

class EnterCodeBottomSheetWidget extends ConsumerStatefulWidget {
  const EnterCodeBottomSheetWidget({
    super.key,
  });

  @override
  ConsumerState<EnterCodeBottomSheetWidget> createState() =>
      _EnterCodeBottomSheetWidgetState();
}

class _EnterCodeBottomSheetWidgetState
    extends ConsumerState<EnterCodeBottomSheetWidget> {
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '코드 입력',
                  style: AppTextStyles.textSb20,
                ),
                CloseButton(),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _codeController,
              onChanged: (_) {
                setState(() {});
              },
              decoration: const InputDecoration(
                hintText: '코드를 입력해주세요',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: FilledTextButtonWidget(
                    title: '입력',
                    isEnabled: _codeController.text.isNotEmpty,
                    onPressed: () {
                      // viewModel.enterCode(
                      //   codeController.text,
                      // );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}

class MealHeatBar extends StatelessWidget {
  final List<double> frequency; // 24개, 0~1

  const MealHeatBar({required this.frequency, super.key});

  @override
  Widget build(BuildContext context) {
    const double barHeight = 32;
    final double barWidth = (MediaQuery.of(context).size.width - 64 - 48) / 24;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: barHeight,
          child: Row(
            children: List<Widget>.generate(24, (int i) {
              final double value = frequency[i].clamp(0.0, 1.0);
              return Container(
                width: barWidth,
                height: barHeight,
                margin: const EdgeInsets.symmetric(horizontal: 1),
                decoration: BoxDecoration(
                  color: getHeatColor(value),
                  borderRadius: BorderRadius.circular(6),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('0시'),
            Text('6시'),
            Text('12시'),
            Text('18시'),
            Text('24시'),
          ],
        ),
      ],
    );
  }
}

Color getHeatColor(double value) {
  if (value <= 0.3) {
    return AppColors.gray200;
  } else if (value <= 0.5) {
    return AppColors.main;
  } else if (value <= 0.7) {
    return AppColors.heat1;
  } else {
    return AppColors.heat3;
  }
}

// 24시간을 1시간 단위로 나눈 식사 빈도 (0~1 사이 값)
final List<double> mealFrequency = <double>[
  0.0, 0.0, 0.0, 0.1, 0.2, 0.3, 0.7, 0.9, 0.8, 0.4, // 0~9시
  0.2, 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.6, 0.8, // 10~19시
  0.7, 0.4, 0.2, 0.1 // 20~23시
];
