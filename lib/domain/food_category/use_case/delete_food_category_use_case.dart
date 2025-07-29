import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/food_category/food_category_repository.dart';

final AutoDisposeProvider<DeleteFoodCategoryUseCase>
    deleteFoodCategoryUseCaseProvider =
    Provider.autoDispose<DeleteFoodCategoryUseCase>(
  (Ref<DeleteFoodCategoryUseCase> ref) => DeleteFoodCategoryUseCase(
    foodCategoryRepository: ref.read(foodCategoryRepositoryProvider),
  ),
);

class DeleteFoodCategoryUseCase {
  final FoodCategoryRepository _foodCategoryRepository;
  DeleteFoodCategoryUseCase({
    required FoodCategoryRepository foodCategoryRepository,
  }) : _foodCategoryRepository = foodCategoryRepository;

  Future<UseCaseResult<void>> call({
    required String foodCategoryId,
  }) async {
    final RepositoryResult<void> result =
        await _foodCategoryRepository.deleteFoodCategory(
      foodCategoryId: foodCategoryId,
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
