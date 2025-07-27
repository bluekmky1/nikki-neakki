import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/common/repository/repository.dart';
import '../../core/common/repository/repository_result.dart';
import '../../domain/meal/model/food_category_model.dart';
import 'entity/food_category_entity.dart';
import 'food_category_remote_data_source.dart';

final Provider<FoodCategoryRepository> foodCategoryRepositoryProvider =
    Provider<FoodCategoryRepository>(
  (Ref<FoodCategoryRepository> ref) =>
      FoodCategoryRepository(ref.watch(foodCategoryRemoteDataSourceProvider)),
);

class FoodCategoryRepository extends Repository {
  const FoodCategoryRepository(this._foodCategoryRemoteDataSource);

  final FoodCategoryRemoteDataSource _foodCategoryRemoteDataSource;
}
