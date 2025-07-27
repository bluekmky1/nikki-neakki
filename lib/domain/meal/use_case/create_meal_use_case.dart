import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/meal/meal_repository.dart';
import '../../../ui/common/consts/meal_type.dart';
import '../model/food_model.dart';

final AutoDisposeProvider<CreateMealUseCase> createMealUseCaseProvider =
    Provider.autoDispose<CreateMealUseCase>(
  (Ref<CreateMealUseCase> ref) => CreateMealUseCase(
    mealRepository: ref.read(mealRepositoryProvider),
  ),
);

class CreateMealUseCase {
  final MealRepository _mealRepository;
  CreateMealUseCase({
    required MealRepository mealRepository,
  }) : _mealRepository = mealRepository;

  Future<UseCaseResult<void>> call({
    required String userId,
    required DateTime date,
    required MealType mealType,
    required XFile image,
    required List<FoodModel> foods,
  }) async {
    final RepositoryResult<void> result = await _mealRepository.createMeal(
      userId: userId,
      date: date,
      mealType: mealType,
      image: image,
      foods: foods,
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
