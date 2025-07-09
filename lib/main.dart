import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.gray100,
            scrolledUnderElevation: 0,
          ),
          scaffoldBackgroundColor: AppColors.gray100,
        ),
      );
}
