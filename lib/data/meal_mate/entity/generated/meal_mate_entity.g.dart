// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../meal_mate_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealMateEntity _$MealMateEntityFromJson(Map<String, dynamic> json) =>
    MealMateEntity(
      id: json['id'] as String,
      user1Id: json['user1_id'] as String,
      user2Id: json['user2_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$MealMateEntityToJson(MealMateEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user1_id': instance.user1Id,
      'user2_id': instance.user2Id,
      'created_at': instance.createdAt.toIso8601String(),
    };
