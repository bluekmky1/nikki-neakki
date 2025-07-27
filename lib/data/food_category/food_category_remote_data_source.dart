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
}
