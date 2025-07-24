import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';
import '../../domain/meal/model/meal_model.dart';

class MyState extends Equatable {
  // 식사 목록 조회
  final LoadingStatus getMealsLoadingStatus;
  final List<MealModel> mealList;

  // 파트너 정보 조회
  final LoadingStatus getPartnerLoadingStatus;
  final String mateId;
  final String partnerId;
  final String partnerName;

  const MyState({
    required this.getMealsLoadingStatus,
    required this.mealList,
    required this.getPartnerLoadingStatus,
    required this.mateId,
    required this.partnerId,
    required this.partnerName,
  });

  const MyState.init()
      : getMealsLoadingStatus = LoadingStatus.none,
        mealList = const <MealModel>[],
        getPartnerLoadingStatus = LoadingStatus.none,
        mateId = '',
        partnerId = '',
        partnerName = '';

  MyState copyWith({
    LoadingStatus? getMealsLoadingStatus,
    List<MealModel>? mealList,
    LoadingStatus? getPartnerLoadingStatus,
    String? mateId,
    String? partnerId,
    String? partnerName,
  }) =>
      MyState(
        getMealsLoadingStatus:
            getMealsLoadingStatus ?? this.getMealsLoadingStatus,
        mealList: mealList ?? this.mealList,
        getPartnerLoadingStatus:
            getPartnerLoadingStatus ?? this.getPartnerLoadingStatus,
        mateId: mateId ?? this.mateId,
        partnerId: partnerId ?? this.partnerId,
        partnerName: partnerName ?? this.partnerName,
      );

  @override
  List<Object> get props => <Object>[
        getMealsLoadingStatus,
        mealList,
        getPartnerLoadingStatus,
        mateId,
        partnerId,
        partnerName,
      ];
}
