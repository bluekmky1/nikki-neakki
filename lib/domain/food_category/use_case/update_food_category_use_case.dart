import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/food_category/food_category_repository.dart';

final AutoDisposeProvider<UpdateFoodCategoryUseCase>
    updateFoodCategoryUseCaseProvider =
    Provider.autoDispose<UpdateFoodCategoryUseCase>(
  (Ref<UpdateFoodCategoryUseCase> ref) => UpdateFoodCategoryUseCase(
    foodCategoryRepository: ref.read(foodCategoryRepositoryProvider),
  ),
);

class UpdateFoodCategoryUseCase {
  final FoodCategoryRepository _foodCategoryRepository;
  UpdateFoodCategoryUseCase({
    required FoodCategoryRepository foodCategoryRepository,
  }) : _foodCategoryRepository = foodCategoryRepository;

  Future<UseCaseResult<void>> call({
    required String foodCategoryId,
    required String name,
  }) async {
    final RepositoryResult<void> result =
        await _foodCategoryRepository.updateFoodCategory(
      foodCategoryId: foodCategoryId,
      name: name,
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
