import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../service/supabase/supabase_service.dart';
import 'entity/food_category_entity.dart';

final Provider<FoodCategoryRemoteDataSource>
    foodCategoryRemoteDataSourceProvider =
    Provider<FoodCategoryRemoteDataSource>(
  (Ref<FoodCategoryRemoteDataSource> ref) =>
      FoodCategoryRemoteDataSource(ref.watch(supabaseServiceProvider.notifier)),
);

class FoodCategoryRemoteDataSource {
  const FoodCategoryRemoteDataSource(this._supabaseService);

  final SupabaseService _supabaseService;

  Future<List<FoodCategoryEntity>> getFoodCategories({
    required String userId,
  }) async {
    final List<Map<String, dynamic>> response = await _supabaseService
        .supabaseClient
        .from('food_category')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return response.map(FoodCategoryEntity.fromJson).toList();
  }

  Future<FoodCategoryEntity> createFoodCategory({
    required String userId,
    required String name,
  }) async {
    final Map<String, dynamic> response = await _supabaseService.supabaseClient
        .from('food_category')
        .insert(<String, String>{
          'user_id': userId,
          'name': name,
        })
        .select()
        .single();

    return FoodCategoryEntity.fromJson(response);
  }

  Future<void> deleteFoodCategory({
    required String foodCategoryId,
  }) async {
    await _supabaseService.supabaseClient
        .from('food_category')
        .delete()
        .eq('id', foodCategoryId);
  }

  Future<void> updateFoodCategory({
    required String foodCategoryId,
    required String name,
  }) async {
    await _supabaseService.supabaseClient
        .from('food_category')
        .update(<String, String>{'name': name}).eq('id', foodCategoryId);
  }
}
