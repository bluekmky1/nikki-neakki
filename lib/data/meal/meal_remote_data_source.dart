import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/meal/model/food_model.dart';
import '../../service/supabase/supabase_service.dart';
import '../../ui/common/consts/meal_type.dart';
import 'entity/meal_entity.dart';

final Provider<MealRemoteDataSource> mealRemoteDataSourceProvider =
    Provider<MealRemoteDataSource>(
  (Ref<MealRemoteDataSource> ref) =>
      MealRemoteDataSource(ref.watch(supabaseServiceProvider.notifier)),
);

class MealRemoteDataSource {
  const MealRemoteDataSource(this._supabaseService);

  final SupabaseService _supabaseService;

  Future<Map<String, String>> getFoodCategoryNames({
    required List<String> categoryIds,
    required String userId,
  }) async {
    if (categoryIds.isEmpty) {
      return <String, String>{};
    }

    final PostgrestList response = await _supabaseService.supabaseClient
        .from('food_category')
        .select('id, name')
        .eq('user_id', userId)
        .inFilter('id', categoryIds);

    return Map<String, String>.fromEntries(
      response.map(
        (Map<String, dynamic> category) => MapEntry<String, String>(
          category['id'] as String,
          category['name'] as String,
        ),
      ),
    );
  }

  Future<List<MealEntity>> getMeals({
    required String userId,
    required DateTime date,
  }) async {
    // 1. 기본 meal 데이터 가져오기
    final PostgrestList mealsResponse = await _supabaseService.supabaseClient
        .from('meal')
        .select()
        .gte('meal_time', date.toIso8601String())
        .lte('meal_time', date.add(const Duration(days: 1)).toIso8601String())
        .eq('user_id', userId);

    final List<Map<String, dynamic>> mealsData =
        List<Map<String, dynamic>>.from(mealsResponse);

    // 2. meal_food 데이터 가져오기
    final List<String> mealIds = mealsData
        .map((Map<String, dynamic> meal) => meal['id'] as String)
        .toList();

    final PostgrestList mealFoodsResponse = await _supabaseService
        .supabaseClient
        .from('meal_food')
        .select()
        .inFilter('meal_id', mealIds);

    final List<Map<String, dynamic>> mealFoodsData =
        List<Map<String, dynamic>>.from(mealFoodsResponse);

    // 3. meal 데이터에 foods 추가
    final List<Map<String, dynamic>> mealsWithFoods =
        mealsData.map((Map<String, dynamic> meal) {
      final String mealId = meal['id'] as String;
      final List<Map<String, dynamic>> foods = mealFoodsData
          .where((Map<String, dynamic> food) => food['meal_id'] == mealId)
          .toList();

      return <String, dynamic>{
        ...meal,
        'foods': foods,
      };
    }).toList();

    final List<MealEntity> meals =
        mealsWithFoods.map(MealEntity.fromJson).toList();

    return meals;
  }

  Future<void> createMeal({
    required String userId,
    required DateTime mealTime,
    required MealType mealType,
    required XFile image,
    required List<FoodModel> foods,
  }) async {
    final String imageUrl = await _supabaseService.uploadImage(image);

    final PostgrestList response = await _supabaseService.supabaseClient
        .from('meal')
        .insert(<String, dynamic>{
      'user_id': userId,
      'meal_time': mealTime.toIso8601String(),
      'image_url': imageUrl,
      'meal_type': mealType.value,
      'created_at': DateTime.now().toIso8601String(),
    }).select();

    final String mealId = response.first['id'] as String;

    for (final FoodModel food in foods) {
      await _supabaseService.supabaseClient
          .from('meal_food')
          .insert(<String, dynamic>{
        'category_id': food.categoryId,
        'user_id': userId,
        'meal_id': mealId,
        'food_note': food.name,
      });
    }
  }

  Future<void> deleteMeal({
    required String userId,
    required String mealId,
    required String imageUrl,
  }) async {
    await _supabaseService.supabaseClient
        .from('meal')
        .delete()
        .eq('id', mealId)
        .eq('user_id', userId);

    await _supabaseService.deleteImage(imageUrl);
  }

  Future<List<MealEntity>> getMealsListWithPagination({
    required String userId,
    int? limit,
    String? cursor,
  }) async {
    // 1. 기본 meal 데이터 가져오기
    final PostgrestList mealsResponse;

    final int limitCount = limit ?? 10;

    if (cursor != null) {
      // cursor가 있으면 해당 시점 이전의 데이터만 가져오기 (중복 방지를 위해 < 조건 사용)
      mealsResponse = await _supabaseService.supabaseClient
          .from('meal')
          .select()
          .eq('user_id', userId)
          .filter('created_at', 'lt', cursor)
          .order('created_at', ascending: false)
          .limit(limitCount);
    } else {
      // cursor가 없으면 전체 데이터 가져오기
      mealsResponse = await _supabaseService.supabaseClient
          .from('meal')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false)
          .limit(limitCount);
    }

    final List<Map<String, dynamic>> mealsData =
        List<Map<String, dynamic>>.from(mealsResponse);

    // 2. meal_food 데이터 가져오기
    final List<String> mealIds = mealsData
        .map((Map<String, dynamic> meal) => meal['id'] as String)
        .toList();

    if (mealIds.isEmpty) {
      return <MealEntity>[];
    }

    final PostgrestList mealFoodsResponse = await _supabaseService
        .supabaseClient
        .from('meal_food')
        .select()
        .inFilter('meal_id', mealIds);

    final List<Map<String, dynamic>> mealFoodsData =
        List<Map<String, dynamic>>.from(mealFoodsResponse);

    // 3. meal 데이터에 foods 추가
    final List<Map<String, dynamic>> mealsWithFoods =
        mealsData.map((Map<String, dynamic> meal) {
      final String mealId = meal['id'] as String;
      final List<Map<String, dynamic>> foods = mealFoodsData
          .where((Map<String, dynamic> food) => food['meal_id'] == mealId)
          .toList();

      return <String, dynamic>{
        ...meal,
        'foods': foods,
      };
    }).toList();

    final List<MealEntity> meals =
        mealsWithFoods.map(MealEntity.fromJson).toList();

    return meals;
  }

  Future<List<MealEntity>> searchMeals({
    required String userId,
    required String searchKeyword,
    int? limit, // 검색은 최대 50개까지만 표시
  }) async {
    // 1. meal_food 테이블에서 food_note로 검색하여 meal_id 찾기
    final PostgrestList mealFoodsResponse = await _supabaseService
        .supabaseClient
        .from('meal_food')
        .select('meal_id')
        .eq('user_id', userId)
        .filter('food_note', 'ilike', '%$searchKeyword%');

    final List<String> mealIds = mealFoodsResponse
        .map((dynamic item) => item['meal_id'] as String)
        .toSet() // 중복 제거
        .toList();

    if (mealIds.isEmpty) {
      return <MealEntity>[];
    }

    // 2. 찾은 meal_id들로 meal 데이터만 가져오기 (foods 정보 없이)
    final PostgrestList mealsResponse = await _supabaseService.supabaseClient
        .from('meal')
        .select()
        .eq('user_id', userId)
        .inFilter('id', mealIds)
        .order('created_at', ascending: false)
        .limit(limit ?? 50);

    final List<Map<String, dynamic>> mealsData =
        List<Map<String, dynamic>>.from(mealsResponse);

    // 3. 빈 foods 배열과 함께 MealEntity 생성
    final List<Map<String, dynamic>> mealsWithEmptyFoods = mealsData
        .map((Map<String, dynamic> meal) => <String, dynamic>{
              ...meal,
              'foods': <Map<String, dynamic>>[],
            })
        .toList();

    final List<MealEntity> meals =
        mealsWithEmptyFoods.map(MealEntity.fromJson).toList();

    return meals;
  }

  Future<MealEntity> getMealById({
    required String mealId,
  }) async {
    // single()을 사용하여 하나의 Map<String, dynamic> 객체 반환
    final Map<String, dynamic> mealResponse = await _supabaseService
        .supabaseClient
        .from('meal')
        .select()
        .eq('id', mealId)
        .single();

    // meal_food 데이터 가져오기
    final PostgrestList mealFoodsResponse = await _supabaseService
        .supabaseClient
        .from('meal_food')
        .select()
        .eq('meal_id', mealId);

    final List<Map<String, dynamic>> mealFoodsData =
        List<Map<String, dynamic>>.from(mealFoodsResponse);

    // meal 데이터에 foods 추가
    final Map<String, dynamic> mealWithFoods = <String, dynamic>{
      ...mealResponse,
      'foods': mealFoodsData,
    };

    return MealEntity.fromJson(mealWithFoods);
  }
}
