import 'route_info.dart';

class Routes {
  // auth
  static const RouteInfo auth = RouteInfo(
    name: '/auth',
    path: '/auth',
  );

  static const RouteInfo login = RouteInfo(
    name: 'auth/login',
    path: '/login',
  );

  // 홈(메인)페이지
  static const RouteInfo home = RouteInfo(
    name: '/home',
    path: '/home',
  );

  // 음식 기록
  static const RouteInfo recordFood = RouteInfo(
    name: '/record-food',
    path: '/record-food',
  );

  // 자주 먹는 음식들 관리
  static const RouteInfo frequentlyEatenFoods = RouteInfo(
    name: '/frequently-eaten-foods',
    path: '/frequently-eaten-foods',
  );

  // 자주 먹는 음식들 관리 설정
  static const RouteInfo frequentlyEatenFoodsSetting = RouteInfo(
    name: '/frequently-eaten-foods/setting',
    path: '/frequently-eaten-foods/setting',
  );

  // 마이페이지
  static const RouteInfo myPage = RouteInfo(
    name: '/my-page',
    path: '/my-page',
  );
}
