import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  '니끼내끼',
                  style: AppTextStyles.appTitle.copyWith(
                    color: AppColors.deepMain,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: TextButton(
                  onPressed: () {
                    context.goNamed(Routes.home.name);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.main,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          '로그인',
                          style: AppTextStyles.textB18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
