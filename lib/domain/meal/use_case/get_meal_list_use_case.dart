import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/meal/entity/meal_entity.dart';
import '../../../data/meal/meal_repository.dart';

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
    final RepositoryResult<List<MealEntity>> result =
        await _mealRepository.getMeals(
      userId: userId,
      date: date,
    );
    return switch (result) {
      SuccessRepositoryResult<List<MealEntity>>() =>
        SuccessUseCaseResult<List<MealModel>>(
          data: List<MealModel>.generate(
            result.data.length,
            (int index) => MealModel.fromEntity(
              entity: result.data[index],
            ),
          ),
        ),
      FailureRepositoryResult<List<MealEntity>>() =>
        FailureUseCaseResult<List<MealModel>>(message: result.messages?[0])
    };
  }
}
