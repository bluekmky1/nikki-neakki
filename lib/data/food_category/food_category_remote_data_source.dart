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
}
