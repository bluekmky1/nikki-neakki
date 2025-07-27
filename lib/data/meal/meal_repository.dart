import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/common/repository/repository.dart';
import '../../core/common/repository/repository_result.dart';
import '../../domain/meal/model/food_model.dart';
import '../../ui/common/consts/meal_type.dart';
import 'entity/meal_entity.dart';
import 'meal_remote_data_source.dart';

final Provider<MealRepository> mealRepositoryProvider =
    Provider<MealRepository>(
  (Ref<MealRepository> ref) =>
      MealRepository(ref.watch(mealRemoteDataSourceProvider)),
);

class MealRepository extends Repository {
  const MealRepository(this._mealRemoteDataSource);

  final MealRemoteDataSource _mealRemoteDataSource;

  Future<RepositoryResult<List<MealEntity>>> getMeals({
    required String userId,
    required DateTime date,
  }) async {
    try {
      final List<MealEntity> entity = await _mealRemoteDataSource.getMeals(
        userId: userId,
        date: date,
      );

      return SuccessRepositoryResult<List<MealEntity>>(
        data: entity,
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<List<MealEntity>>(
        error: e,
        messages: <String>[
          '식사 메이트 정보를 조회하는 과정에 오류가 발생했습니다: ${e.message}',
        ],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<List<MealEntity>>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<List<MealEntity>>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }

  // 식사 생성
  Future<RepositoryResult<void>> createMeal({
    required String userId,
    required DateTime date,
    required MealType mealType,
    required XFile image,
    required List<FoodModel> foods,
  }) async {
    try {
      await _mealRemoteDataSource.createMeal(
        userId: userId,
        mealTime: date,
        mealType: mealType,
        image: image,
        foods: foods,
      );

      return const SuccessRepositoryResult<void>(
        data: null,
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<List<MealEntity>>(
        error: e,
        messages: <String>[
          '식사 생성 과정에 오류가 발생했습니다: ${e.message}',
        ],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<List<MealEntity>>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<List<MealEntity>>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }
}
