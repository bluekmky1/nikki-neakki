// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../food_category_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodCategoryEntity _$FoodCategoryEntityFromJson(Map<String, dynamic> json) =>
    FoodCategoryEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$FoodCategoryEntityToJson(FoodCategoryEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
