import 'package:equatable/equatable.dart';

import '../../../../core/loading_status.dart';
import '../../domain/meal/model/meal_model.dart';
import '../common/consts/invitation_status.dart';

class MyState extends Equatable {
  // 식사 목록 조회
  final LoadingStatus getMealsLoadingStatus;
  final List<MealModel> mealList;

  // 파트너 정보 조회
  final LoadingStatus getPartnerLoadingStatus;
  final String mealMateId;
  final String mealMateUserName;

  // 초대 정보 조회
  final LoadingStatus getInvitationLoadingStatus;
  final InvitationStatus invitationStatus;
  final String mealMateCode;
  final DateTime mealMateCodeExpiryDate;

  // 초대 생성
  final LoadingStatus createInvitationLoadingStatus;

  // 초대 코드 입력
  final LoadingStatus enterInvitationCodeLoadingStatus;

  const MyState({
    required this.getMealsLoadingStatus,
    required this.mealList,
    required this.getPartnerLoadingStatus,
    required this.mealMateId,
    required this.mealMateUserName,
    required this.getInvitationLoadingStatus,
    required this.invitationStatus,
    required this.mealMateCode,
    required this.mealMateCodeExpiryDate,
    required this.createInvitationLoadingStatus,
    required this.enterInvitationCodeLoadingStatus,
  });

  MyState.init()
      : getMealsLoadingStatus = LoadingStatus.none,
        mealList = const <MealModel>[],
        getPartnerLoadingStatus = LoadingStatus.none,
        mealMateId = '',
        mealMateUserName = '',
        getInvitationLoadingStatus = LoadingStatus.none,
        invitationStatus = InvitationStatus.none,
        mealMateCode = '',
        mealMateCodeExpiryDate = DateTime(1900),
        createInvitationLoadingStatus = LoadingStatus.none,
        enterInvitationCodeLoadingStatus = LoadingStatus.none;

  MyState copyWith({
    LoadingStatus? getMealsLoadingStatus,
    List<MealModel>? mealList,
    LoadingStatus? getPartnerLoadingStatus,
    String? mealMateId,
    String? mealMateUserName,
    LoadingStatus? getInvitationLoadingStatus,
    InvitationStatus? invitationStatus,
    String? mealMateCode,
    DateTime? mealMateCodeExpiryDate,
    LoadingStatus? createInvitationLoadingStatus,
    LoadingStatus? enterInvitationCodeLoadingStatus,
  }) =>
      MyState(
        getMealsLoadingStatus:
            getMealsLoadingStatus ?? this.getMealsLoadingStatus,
        mealList: mealList ?? this.mealList,
        getPartnerLoadingStatus:
            getPartnerLoadingStatus ?? this.getPartnerLoadingStatus,
        mealMateId: mealMateId ?? this.mealMateId,
        mealMateUserName: mealMateUserName ?? this.mealMateUserName,
        getInvitationLoadingStatus:
            getInvitationLoadingStatus ?? this.getInvitationLoadingStatus,
        invitationStatus: invitationStatus ?? this.invitationStatus,
        mealMateCode: mealMateCode ?? this.mealMateCode,
        mealMateCodeExpiryDate:
            mealMateCodeExpiryDate ?? this.mealMateCodeExpiryDate,
        createInvitationLoadingStatus:
            createInvitationLoadingStatus ?? this.createInvitationLoadingStatus,
        enterInvitationCodeLoadingStatus: enterInvitationCodeLoadingStatus ??
            this.enterInvitationCodeLoadingStatus,
      );

  @override
  List<Object?> get props => <Object?>[
        getMealsLoadingStatus,
        mealList,
        getPartnerLoadingStatus,
        mealMateId,
        mealMateUserName,
        getInvitationLoadingStatus,
        invitationStatus,
        mealMateCode,
        mealMateCodeExpiryDate,
        createInvitationLoadingStatus,
        enterInvitationCodeLoadingStatus,
      ];

  bool get hasPartner => mealMateId.isEmpty;

  bool get isLoading =>
      getInvitationLoadingStatus == LoadingStatus.none ||
      getInvitationLoadingStatus == LoadingStatus.loading;

  // getMealsLoadingStatus == LoadingStatus.loading ||
  // getPartnerLoadingStatus == LoadingStatus.loading ||
  // getMealsLoadingStatus == LoadingStatus.none ||
  // getPartnerLoadingStatus == LoadingStatus.none;
}
