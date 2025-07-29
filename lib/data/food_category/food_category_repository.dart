import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/common/repository/repository.dart';
import '../../core/common/repository/repository_result.dart';
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

  Future<RepositoryResult<List<FoodCategoryEntity>>> getFoodCategories({
    required String userId,
  }) async {
    try {
      final List<FoodCategoryEntity> foodCategories =
          await _foodCategoryRemoteDataSource.getFoodCategories(
        userId: userId,
      );
      return SuccessRepositoryResult<List<FoodCategoryEntity>>(
        data: foodCategories,
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<List<FoodCategoryEntity>>(
        error: e,
        messages: <String>['음식 카테고리를 조회하는 과정에 오류가 발생했습니다: ${e.message}'],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<List<FoodCategoryEntity>>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<List<FoodCategoryEntity>>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }

  Future<RepositoryResult<FoodCategoryEntity>> createFoodCategory({
    required String userId,
    required String name,
  }) async {
    try {
      final FoodCategoryEntity foodCategory =
          await _foodCategoryRemoteDataSource.createFoodCategory(
        userId: userId,
        name: name,
      );
      return SuccessRepositoryResult<FoodCategoryEntity>(
        data: foodCategory,
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<FoodCategoryEntity>(
        error: e,
        messages: <String>['음식 카테고리를 생성하는 과정에 오류가 발생했습니다: ${e.message}'],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<FoodCategoryEntity>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<FoodCategoryEntity>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }

  Future<RepositoryResult<void>> deleteFoodCategory({
    required String foodCategoryId,
  }) async {
    try {
      await _foodCategoryRemoteDataSource.deleteFoodCategory(
        foodCategoryId: foodCategoryId,
      );
      return const SuccessRepositoryResult<void>(
        data: null,
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<void>(
        error: e,
        messages: <String>['음식 카테고리를 삭제하는 과정에 오류가 발생했습니다: ${e.message}'],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<void>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<void>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }

  Future<RepositoryResult<void>> updateFoodCategory({
    required String foodCategoryId,
    required String name,
  }) async {
    try {
      await _foodCategoryRemoteDataSource.updateFoodCategory(
        foodCategoryId: foodCategoryId,
        name: name,
      );
      return const SuccessRepositoryResult<void>(
        data: null,
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<void>(
        error: e,
        messages: <String>['음식 카테고리를 수정하는 과정에 오류가 발생했습니다: ${e.message}'],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<void>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<void>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }
}
