import 'package:json_annotation/json_annotation.dart';

part 'generated/food_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FoodEntity {
  final String id;
  final String mealId;
  final String categoryId;
  final String userId;
  final String foodNote;
  final DateTime createdAt;

  const FoodEntity({
    required this.id,
    required this.mealId,
    required this.categoryId,
    required this.userId,
    required this.foodNote,
    required this.createdAt,
  });

  factory FoodEntity.fromJson(Map<String, dynamic> json) =>
      _$FoodEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FoodEntityToJson(this);
}
