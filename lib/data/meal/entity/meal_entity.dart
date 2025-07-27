import 'package:json_annotation/json_annotation.dart';

import 'food_entity.dart';

part 'generated/meal_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MealEntity {
  final String id;
  final String userId;
  final String? imageUrl;
  final DateTime mealTime;
  final String mealType;
  final DateTime createdAt;
  final List<FoodEntity> foods;

  const MealEntity({
    required this.id,
    required this.userId,
    required this.imageUrl,
    required this.mealTime,
    required this.mealType,
    required this.createdAt,
    required this.foods,
  });

  factory MealEntity.fromJson(Map<String, dynamic> json) =>
      _$MealEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MealEntityToJson(this);
}
