import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/meal_mate/meal_mate_repository.dart';

final AutoDisposeProvider<GetMealMateUserNameUseCase>
    getMealMateUserNameUseCaseProvider =
    Provider.autoDispose<GetMealMateUserNameUseCase>(
  (Ref<GetMealMateUserNameUseCase> ref) => GetMealMateUserNameUseCase(
    mealMateRepository: ref.read(mealMateRepositoryProvider),
  ),
);

class GetMealMateUserNameUseCase {
  final MealMateRepository _mealMateRepository;
  GetMealMateUserNameUseCase({
    required MealMateRepository mealMateRepository,
  }) : _mealMateRepository = mealMateRepository;

  Future<UseCaseResult<String>> call({
    required String userId,
  }) async {
    final RepositoryResult<String> result =
        await _mealMateRepository.getMateUserName(
      userId: userId,
    );

    return switch (result) {
      SuccessRepositoryResult<String>() => SuccessUseCaseResult<String>(
          data: result.data,
        ),
      FailureRepositoryResult<String>() => FailureUseCaseResult<String>(
          message: result.messages?[0],
        )
    };
  }
}
