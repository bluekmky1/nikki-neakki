import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'routes/app_router.dart';
import 'service/supabase/supabase_service.dart';
import 'theme/app_colors.dart';
import 'theme/app_text_styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // .env 파일 로드
  await dotenv.load();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    super.initState();
    // Supabase 초기화
    ref.read(supabaseServiceProvider.notifier).initialize();
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerConfig: ref.watch(appRouterProvider).router,
        title: '니끼내끼',
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
            centerTitle: true,
          ),
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: AppColors.white,
          ),
          scaffoldBackgroundColor: AppColors.gray100,
          snackBarTheme: SnackBarThemeData(
            backgroundColor: AppColors.gray900,
            contentTextStyle: AppTextStyles.textM16.copyWith(
              color: AppColors.white,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            behavior: SnackBarBehavior.floating,
          ),
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
