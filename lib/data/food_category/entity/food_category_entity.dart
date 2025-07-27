import 'package:json_annotation/json_annotation.dart';

part 'generated/food_category_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FoodCategoryEntity {
  final String id;
  final String name;
  final DateTime createdAt;

  const FoodCategoryEntity({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory FoodCategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$FoodCategoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FoodCategoryEntityToJson(this);
}
