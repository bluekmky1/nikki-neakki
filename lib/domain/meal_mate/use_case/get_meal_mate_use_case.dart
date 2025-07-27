import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/meal_mate/entity/meal_mate_entity.dart';
import '../../../data/meal_mate/meal_mate_repository.dart';
import '../model/meal_mate_model.dart';

final AutoDisposeProvider<GetMealMateUseCase> getMealMateUseCaseProvider =
    Provider.autoDispose<GetMealMateUseCase>(
  (Ref<GetMealMateUseCase> ref) => GetMealMateUseCase(
    mealMateRepository: ref.read(mealMateRepositoryProvider),
  ),
);

class GetMealMateUseCase {
  final MealMateRepository _mealMateRepository;
  GetMealMateUseCase({
    required MealMateRepository mealMateRepository,
  }) : _mealMateRepository = mealMateRepository;

  Future<UseCaseResult<MealMateModel>> call({
    required String userId,
  }) async {
    final RepositoryResult<MealMateEntity?> result =
        await _mealMateRepository.getMealMate(
      userId: userId,
    );

    return switch (result) {
      SuccessRepositoryResult<MealMateEntity?>() =>
        SuccessUseCaseResult<MealMateModel>(
          data: MealMateModel.fromEntity(entity: result.data),
        ),
      FailureRepositoryResult<MealMateEntity?>() =>
        FailureUseCaseResult<MealMateModel>(
          message: result.messages?[0],
        )
    };
  }
}
