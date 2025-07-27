import 'package:json_annotation/json_annotation.dart';

part 'generated/meal_mate_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MealMateEntity {
  final String id;
  final String user1Id;
  final String user2Id;
  final DateTime createdAt;

  const MealMateEntity({
    required this.id,
    required this.user1Id,
    required this.user2Id,
    required this.createdAt,
  });

  factory MealMateEntity.fromJson(Map<String, dynamic> json) =>
      _$MealMateEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MealMateEntityToJson(this);
}
