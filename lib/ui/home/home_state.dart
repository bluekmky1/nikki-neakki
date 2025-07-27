import 'package:equatable/equatable.dart';
import '../../core/loading_status.dart';
import '../../domain/meal/model/meal_model.dart';

class HomeState extends Equatable {
  // 데이터 로딩 상태
  // 전체 식사 데이터 로딩 상태
  final LoadingStatus getMyMealsLoadingStatus;
  final LoadingStatus getOtherMealsLoadingStatus;
  final List<MealModel> myMeals;
  final List<MealModel> otherMeals;

  // 선택 날짜
  final DateTime selectedDate;
  // 표시 주차 시작 날짜
  final DateTime displayWeekStartDate;
  // 선택 탭 인덱스
  final int selectedTabIndex;
  // 파트너 Id
  final String partnerId;
  // 점프 여부 (애니메이션 없이 즉시 이동)
  final bool shouldJump;

  const HomeState({
    required this.getMyMealsLoadingStatus,
    required this.getOtherMealsLoadingStatus,
    required this.selectedDate,
    required this.displayWeekStartDate,
    required this.selectedTabIndex,
    required this.partnerId,
    required this.myMeals,
    required this.otherMeals,
    required this.shouldJump,
  });

  HomeState.init()
      : getMyMealsLoadingStatus = LoadingStatus.none,
        getOtherMealsLoadingStatus = LoadingStatus.none,
        selectedDate = DateTime.now(),
        displayWeekStartDate = DateTime.now(),
        selectedTabIndex = 0,
        partnerId = '',
        myMeals = <MealModel>[],
        otherMeals = <MealModel>[],
        shouldJump = false;

  HomeState copyWith({
    LoadingStatus? getMyMealsLoadingStatus,
    LoadingStatus? getOtherMealsLoadingStatus,
    DateTime? selectedDate,
    DateTime? displayWeekStartDate,
    int? selectedTabIndex,
    String? partnerId,
    List<MealModel>? myMeals,
    List<MealModel>? otherMeals,
    bool? shouldJump,
  }) =>
      HomeState(
        getMyMealsLoadingStatus:
            getMyMealsLoadingStatus ?? this.getMyMealsLoadingStatus,
        getOtherMealsLoadingStatus:
            getOtherMealsLoadingStatus ?? this.getOtherMealsLoadingStatus,
        selectedDate: selectedDate ?? this.selectedDate,
        displayWeekStartDate: displayWeekStartDate ?? this.displayWeekStartDate,
        selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
        partnerId: partnerId ?? this.partnerId,
        myMeals: myMeals ?? this.myMeals,
        otherMeals: otherMeals ?? this.otherMeals,
        shouldJump: shouldJump ?? this.shouldJump,
      );

  @override
  List<Object> get props => <Object>[
        getMyMealsLoadingStatus,
        getOtherMealsLoadingStatus,
        selectedDate,
        selectedTabIndex,
        partnerId,
        myMeals,
        otherMeals,
        shouldJump,
      ];

  bool get isToday {
    final DateTime now = DateTime.now();
    return selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day;
  }

  bool get hasPartner => partnerId.isNotEmpty;

  bool get isInDisplayWeek =>
      !selectedDate.isBefore(displayWeekStartDate) &&
      !selectedDate.isAfter(displayWeekStartDate.add(const Duration(days: 6)));
}
