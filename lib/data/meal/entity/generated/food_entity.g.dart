// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../food_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodEntity _$FoodEntityFromJson(Map<String, dynamic> json) => FoodEntity(
      id: json['id'] as String,
      mealId: json['meal_id'] as String,
      categoryId: json['category_id'] as String,
      userId: json['user_id'] as String,
      foodNote: json['food_note'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$FoodEntityToJson(FoodEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'meal_id': instance.mealId,
      'category_id': instance.categoryId,
      'user_id': instance.userId,
      'food_note': instance.foodNote,
      'created_at': instance.createdAt.toIso8601String(),
    };
