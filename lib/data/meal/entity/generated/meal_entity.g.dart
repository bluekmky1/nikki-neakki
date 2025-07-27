// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../meal_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealEntity _$MealEntityFromJson(Map<String, dynamic> json) => MealEntity(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      imageUrl: json['image_url'] as String?,
      mealTime: DateTime.parse(json['meal_time'] as String),
      mealType: json['meal_type'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      foods: (json['foods'] as List<dynamic>)
          .map((e) => FoodEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MealEntityToJson(MealEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'image_url': instance.imageUrl,
      'meal_time': instance.mealTime.toIso8601String(),
      'meal_type': instance.mealType,
      'created_at': instance.createdAt.toIso8601String(),
      'foods': instance.foods,
    };
