import 'route_info.dart';

class Routes {
  // auth
  static const RouteInfo auth = RouteInfo(
    name: '/auth',
    path: '/auth',
  );

  static const RouteInfo login = RouteInfo(
    name: '/auth/login',
    path: 'login',
  );

  // 홈(메인)페이지
  static const RouteInfo home = RouteInfo(
    name: '/home',
    path: '/home',
  );

  // 음식 기록
  static const RouteInfo recordFood = RouteInfo(
    name: '/record-food/:mealType',
    path: '/record-food/:mealType',
  );

  // 식사 검색
  static const RouteInfo mealSearch = RouteInfo(
    name: '/meal-search',
    path: '/meal-search',
  );

  // 식사 상세
  static const RouteInfo mealDetail = RouteInfo(
    name: '/meal-detail/:mealId',
    path: '/meal-detail/:mealId',
  );

  // 자주 먹는 음식들 관리 설정
  static const RouteInfo foodsSetting = RouteInfo(
    name: '/foods-setting',
    path: '/foods-setting',
  );

  // 마이페이지
  static const RouteInfo myPage = RouteInfo(
    name: '/my-page',
    path: '/my-page',
  );
}
