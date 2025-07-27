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
      'meal_type': mealType.name,
      'created_at': DateTime.now().toIso8601String(),
    });

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
}
