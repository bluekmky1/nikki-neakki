import 'package:equatable/equatable.dart';
import '../../core/loading_status.dart';
import '../../domain/meal/model/meal_model.dart';

class MealDetailState extends Equatable {
  final LoadingStatus loadingStatus;
  final MealModel? meal;
  final bool isMyMeal;
  final String partnerNickname;
  final bool showDeleteConfirmation;

  const MealDetailState({
    required this.loadingStatus,
    required this.meal,
    required this.isMyMeal,
    required this.partnerNickname,
    required this.showDeleteConfirmation,
  });

  const MealDetailState.init()
      : loadingStatus = LoadingStatus.none,
        meal = null,
        isMyMeal = true,
        partnerNickname = '',
        showDeleteConfirmation = false;

  MealDetailState copyWith({
    LoadingStatus? loadingStatus,
    MealModel? meal,
    bool? isMyMeal,
    String? partnerNickname,
    bool? showDeleteConfirmation,
  }) =>
      MealDetailState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        meal: meal ?? this.meal,
        isMyMeal: isMyMeal ?? this.isMyMeal,
        partnerNickname: partnerNickname ?? this.partnerNickname,
        showDeleteConfirmation:
            showDeleteConfirmation ?? this.showDeleteConfirmation,
      );

  @override
  List<Object?> get props => <Object?>[
        loadingStatus,
        meal,
        isMyMeal,
        partnerNickname,
        showDeleteConfirmation,
      ];
}
