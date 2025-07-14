import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'routes/app_router.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
        routerConfig: ref.watch(appRouterProvider).router,
        title: 'damudna',
        locale: const Locale('ko', 'KR'),
        supportedLocales: const <Locale>[
          Locale('ko', 'KR'),
          Locale('en', 'US'),
        ],
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.gray100,
            scrolledUnderElevation: 0,
          ),
          scaffoldBackgroundColor: AppColors.gray100,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppColors.deepMain,
            selectionHandleColor: AppColors.deepMain,
            selectionColor: AppColors.deepMain.withValues(alpha: 0.2),
          ),
          cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
            primaryColor: AppColors.deepMain,
          ),
          inputDecorationTheme: const InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.main,
                width: 2,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.gray400,
              ),
            ),
          ),
          datePickerTheme: DatePickerThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              labelStyle: TextStyle(
                color: AppColors.gray900,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.main,
                ),
              ),
            ),
            todayForegroundColor: WidgetStateProperty.all(AppColors.deepMain),
            todayBackgroundColor: WidgetStateProperty.resolveWith(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.main;
                }
                return AppColors.white;
              },
            ),
            yearForegroundColor: WidgetStateProperty.resolveWith(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.disabled)) {
                  return AppColors.gray400;
                }
                if (states.contains(WidgetState.selected)) {
                  return AppColors.deepMain;
                }
                return AppColors.gray900;
              },
            ),
            yearBackgroundColor: WidgetStateProperty.resolveWith(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.main;
                }
                return AppColors.white;
              },
            ),
            headerForegroundColor: AppColors.gray900,
            dayForegroundColor: WidgetStateProperty.resolveWith(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.disabled)) {
                  return AppColors.gray400;
                }
                if (states.contains(WidgetState.selected)) {
                  return AppColors.deepMain;
                }
                return AppColors.gray900;
              },
            ),
            dayBackgroundColor: WidgetStateProperty.resolveWith(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.main;
                }
                return AppColors.white;
              },
            ),
            backgroundColor: AppColors.white,
            confirmButtonStyle: TextButton.styleFrom(
              foregroundColor: AppColors.gray900,
            ),
            cancelButtonStyle: TextButton.styleFrom(
              foregroundColor: AppColors.gray900,
            ),
          ),
        ),
      );
}
