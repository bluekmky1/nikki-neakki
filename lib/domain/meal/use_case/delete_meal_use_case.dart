import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/meal/meal_repository.dart';

final AutoDisposeProvider<DeleteMealUseCase> deleteMealUseCaseProvider =
    Provider.autoDispose<DeleteMealUseCase>(
  (Ref<DeleteMealUseCase> ref) => DeleteMealUseCase(
    mealRepository: ref.read(mealRepositoryProvider),
  ),
);

class DeleteMealUseCase {
  final MealRepository _mealRepository;
  DeleteMealUseCase({
    required MealRepository mealRepository,
  }) : _mealRepository = mealRepository;

  Future<UseCaseResult<void>> call({
    required String userId,
    required String mealId,
    required String imageUrl,
  }) async {
    final RepositoryResult<void> result = await _mealRepository.deleteMeal(
      userId: userId,
      mealId: mealId,
      imageUrl: imageUrl,
    );
    return switch (result) {
      SuccessRepositoryResult<void>() => const SuccessUseCaseResult<void>(
          data: null,
        ),
      FailureRepositoryResult<void>() => FailureUseCaseResult<void>(
          message: result.messages?[0],
        ),
    };
  }
}
