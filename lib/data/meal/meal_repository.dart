import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/common/repository/repository.dart';
import '../../core/common/repository/repository_result.dart';
import 'meal_remote_data_source.dart';
import 'response_body/get_meals_with_category_names_response_body.dart';

final Provider<MealRepository> mealRepositoryProvider =
    Provider<MealRepository>(
  (Ref<MealRepository> ref) =>
      MealRepository(ref.watch(mealRemoteDataSourceProvider)),
);

class MealRepository extends Repository {
  const MealRepository(this._mealRemoteDataSource);

  final MealRemoteDataSource _mealRemoteDataSource;

  Future<RepositoryResult<GetMealsWithCategoryNamesResponseBody>>
      getMealsWithCategoryNames({
    required String userId,
    required DateTime date,
  }) async {
    try {
      final GetMealsWithCategoryNamesResponseBody entity =
          await _mealRemoteDataSource.getMealsWithCategoryNames(
        userId: userId,
        date: date,
      );

      return SuccessRepositoryResult<GetMealsWithCategoryNamesResponseBody>(
        data: entity,
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<GetMealsWithCategoryNamesResponseBody>(
        error: e,
        messages: <String>[
          '식사 메이트 정보를 조회하는 과정에 오류가 발생했습니다: ${e.message}',
        ],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<GetMealsWithCategoryNamesResponseBody>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<GetMealsWithCategoryNamesResponseBody>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }
}
