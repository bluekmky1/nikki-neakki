import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/meal/meal_repository.dart';

import '../../../data/meal/response_body/get_meals_with_category_names_response_body.dart';
import '../model/meal_model.dart';

final AutoDisposeProvider<GetMealListUseCase> getMealListUseCaseProvider =
    Provider.autoDispose<GetMealListUseCase>(
  (Ref<GetMealListUseCase> ref) => GetMealListUseCase(
    mealRepository: ref.read(mealRepositoryProvider),
  ),
);

class GetMealListUseCase {
  final MealRepository _mealRepository;
  GetMealListUseCase({
    required MealRepository mealRepository,
  }) : _mealRepository = mealRepository;

  Future<UseCaseResult<List<MealModel>>> call({
    required String userId,
    required DateTime date,
  }) async {
    final RepositoryResult<GetMealsWithCategoryNamesResponseBody> result =
        await _mealRepository.getMealsWithCategoryNames(
      userId: userId,
      date: date,
    );
    return switch (result) {
      SuccessRepositoryResult<GetMealsWithCategoryNamesResponseBody>() =>
        SuccessUseCaseResult<List<MealModel>>(
          data: result.data.toMealModels(),
        ),
      FailureRepositoryResult<GetMealsWithCategoryNamesResponseBody>() =>
        FailureUseCaseResult<List<MealModel>>(message: result.messages?[0])
    };
  }
}
