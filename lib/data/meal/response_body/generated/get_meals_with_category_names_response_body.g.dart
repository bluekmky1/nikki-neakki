// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../get_meals_with_category_names_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMealsWithCategoryNamesResponseBody
    _$GetMealsWithCategoryNamesResponseBodyFromJson(
            Map<String, dynamic> json) =>
        GetMealsWithCategoryNamesResponseBody(
          meals: (json['meals'] as List<dynamic>)
              .map((e) => MealEntity.fromJson(e as Map<String, dynamic>))
              .toList(),
          categoryNames:
              Map<String, String>.from(json['category_names'] as Map),
        );

Map<String, dynamic> _$GetMealsWithCategoryNamesResponseBodyToJson(
        GetMealsWithCategoryNamesResponseBody instance) =>
    <String, dynamic>{
      'meals': instance.meals,
      'category_names': instance.categoryNames,
    };
