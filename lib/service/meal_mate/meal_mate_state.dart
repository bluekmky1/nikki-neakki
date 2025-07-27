import 'package:equatable/equatable.dart';

import '../../core/loading_status.dart';

class MealMateState extends Equatable {
  final LoadingStatus getMealMateLoadingStatus;
  final LoadingStatus getMateUserNameLoadingStatus;
  final String mealMateId;
  final String mealMateUserId;
  final String mealMateUserName;

  const MealMateState({
    required this.getMealMateLoadingStatus,
    required this.getMateUserNameLoadingStatus,
    required this.mealMateId,
    required this.mealMateUserId,
    required this.mealMateUserName,
  });

  const MealMateState.init()
      : getMealMateLoadingStatus = LoadingStatus.none,
        getMateUserNameLoadingStatus = LoadingStatus.none,
        mealMateId = '',
        mealMateUserId = '',
        mealMateUserName = '';

  MealMateState copyWith({
    LoadingStatus? getMealMateLoadingStatus,
    LoadingStatus? getMateUserNameLoadingStatus,
    String? mealMateId,
    String? mealMateUserId,
    String? mealMateUserName,
  }) =>
      MealMateState(
        getMealMateLoadingStatus:
            getMealMateLoadingStatus ?? this.getMealMateLoadingStatus,
        getMateUserNameLoadingStatus:
            getMateUserNameLoadingStatus ?? this.getMateUserNameLoadingStatus,
        mealMateId: mealMateId ?? this.mealMateId,
        mealMateUserId: mealMateUserId ?? this.mealMateUserId,
        mealMateUserName: mealMateUserName ?? this.mealMateUserName,
      );

  @override
  List<Object> get props => <Object>[
        getMealMateLoadingStatus,
        getMateUserNameLoadingStatus,
        mealMateId,
        mealMateUserId,
        mealMateUserName,
      ];

  bool get hasMealMate => mealMateId.isNotEmpty;
}
