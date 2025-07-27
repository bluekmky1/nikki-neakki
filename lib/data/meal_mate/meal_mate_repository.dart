import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/common/repository/repository.dart';
import '../../core/common/repository/repository_result.dart';
import 'entity/meal_mate_entity.dart';
import 'meal_mate_remote_data_source.dart';

final Provider<MealMateRepository> mealMateRepositoryProvider =
    Provider<MealMateRepository>(
  (Ref<MealMateRepository> ref) =>
      MealMateRepository(ref.watch(mealMateRemoteDataSourceProvider)),
);

class MealMateRepository extends Repository {
  const MealMateRepository(this._mealMateRemoteDataSource);

  final MealMateRemoteDataSource _mealMateRemoteDataSource;

  Future<RepositoryResult<MealMateEntity?>> getMealMate({
    required String userId,
  }) async {
    try {
      final MealMateEntity? entity =
          await _mealMateRemoteDataSource.getMealMate(
        userId: userId,
      );

      return SuccessRepositoryResult<MealMateEntity?>(
        data: entity,
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<MealMateEntity?>(
        error: e,
        messages: <String>['식사 메이트 정보를 조회하는 과정에 오류가 발생했습니다: ${e.message}'],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<MealMateEntity?>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<MealMateEntity?>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }

  Future<RepositoryResult<String>> getMateUserName({
    required String userId,
  }) async {
    try {
      final String userName = await _mealMateRemoteDataSource.getMateUserName(
        userId: userId,
      );

      return SuccessRepositoryResult<String>(
        data: userName,
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<String>(
        error: e,
        messages: <String>['식사 메이트 정보를 조회하는 과정에 오류가 발생했습니다: ${e.message}'],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<String>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<String>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }
}
