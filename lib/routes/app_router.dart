import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../ui/foods_setting/foods_setting_view.dart';
import '../ui/home/home_view.dart';
import '../ui/login/login_view.dart';
import '../ui/meal_detail/meal_detail_view.dart';
import '../ui/meal_search/meal_search_view.dart';
import '../ui/my/my_view.dart';
import '../ui/record_meal/record_meal_view.dart';
import 'app_router_interceptor.dart';
import 'redirect_notifier.dart';
import 'routes.dart';

final Provider<AppRouter> appRouterProvider =
    Provider<AppRouter>((Ref<AppRouter> ref) => AppRouter(
          appRouterInterceptor: AppRouterInterceptor(ref: ref),
          refreshListenable: ref.read(redirectNotifierProvider),
        ));

class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  AppRouter({
    required Listenable refreshListenable,
    required AppRouterInterceptor appRouterInterceptor,
  })  : _appRouterInterceptor = appRouterInterceptor,
        _refreshListenable = refreshListenable;

  final AppRouterInterceptor _appRouterInterceptor;
  final Listenable _refreshListenable;

  // 라우트의 이동마다 호출됩니다.
  FutureOr<String?> _redirect(BuildContext context, GoRouterState state) =>
      _appRouterInterceptor.redirect(context, state);

  late final GoRouter _router = GoRouter(
    initialLocation: Routes.home.name,
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    refreshListenable: _refreshListenable,
    errorBuilder: (BuildContext context, GoRouterState state) => const Scaffold(
      body: Center(
        child: Text('Internal Error'),
      ),
    ),
    redirect: _redirect,
    routes: <RouteBase>[
      GoRoute(
        name: Routes.home.name,
        path: Routes.home.path,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const NoTransitionPage<dynamic>(
          child: HomeView(),
        ),
      ),

      GoRoute(
        name: Routes.recordFood.name,
        path: Routes.recordFood.path,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            NoTransitionPage<dynamic>(
          child: RecordMealView(
            mealType: state.pathParameters['mealType'] ?? '아침',
            date: state.extra! as DateTime,
          ),
        ),
      ),

      GoRoute(
        name: Routes.mealSearch.name,
        path: Routes.mealSearch.path,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const NoTransitionPage<dynamic>(
          child: MealSearchView(),
        ),
      ),

      GoRoute(
        name: Routes.mealDetail.name,
        path: Routes.mealDetail.path,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            NoTransitionPage<dynamic>(
          child: MealDetailView(
            mealId: state.pathParameters['mealId'] ?? '',
          ),
        ),
      ),

      GoRoute(
        name: Routes.foodsSetting.name,
        path: Routes.foodsSetting.path,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const NoTransitionPage<dynamic>(
          child: FoodsSettingView(),
        ),
      ),
      GoRoute(
        name: Routes.myPage.name,
        path: Routes.myPage.path,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const NoTransitionPage<dynamic>(
          child: MyView(),
        ),
      ),

      // Auth
      GoRoute(
        path: Routes.auth.path,
        name: Routes.auth.name,
        redirect: (BuildContext context, GoRouterState state) {
          if (state.fullPath == null || state.fullPath == Routes.auth.path) {
            return Routes.login.name;
          }
          return null;
        },
        routes: <RouteBase>[
          GoRoute(
            name: Routes.login.name,
            path: Routes.login.path,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                const NoTransitionPage<dynamic>(
              child: LoginView(),
            ),
          ),
        ],
      ),
    ],
  );

  GoRouter get router => _router;
}
