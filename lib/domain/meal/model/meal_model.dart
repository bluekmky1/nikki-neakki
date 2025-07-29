import 'package:equatable/equatable.dart';
import '../../../data/meal/entity/meal_entity.dart';
import '../../../ui/common/consts/meal_type.dart';
import 'food_model.dart';

class MealModel extends Equatable {
  final String id;
  final String userId;
  final String imageUrl;
  final DateTime mealTime;
  final MealType mealType;
  final List<FoodModel> foods;
  final DateTime createdAt;

  const MealModel({
    required this.id,
    required this.userId,
    required this.imageUrl,
    required this.mealTime,
    required this.mealType,
    required this.foods,
    required this.createdAt,
  });

  factory MealModel.fromEntity({
    required MealEntity entity,
  }) =>
      MealModel(
        id: entity.id,
        userId: entity.userId,
        imageUrl: entity.imageUrl ?? '',
        mealTime: entity.mealTime,
        mealType: MealType.fromString(entity.mealType),
        foods: List<FoodModel>.generate(
          entity.foods.length,
          (int index) => FoodModel.fromEntity(
            entity: entity.foods[index],
          ),
        ),
        createdAt: entity.createdAt,
      );

  @override
  List<Object?> get props => <Object?>[
        id,
        userId,
        imageUrl,
        mealTime,
        mealType,
        foods,
        createdAt,
      ];
}
