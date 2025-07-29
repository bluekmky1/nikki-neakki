import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/food_category/entity/food_category_entity.dart';
import '../../../data/food_category/food_category_repository.dart';
import '../model/food_category_model.dart';

final AutoDisposeProvider<CreateFoodCategoryUseCase>
    createFoodCategoryUseCaseProvider =
    Provider.autoDispose<CreateFoodCategoryUseCase>(
  (Ref<CreateFoodCategoryUseCase> ref) => CreateFoodCategoryUseCase(
    foodCategoryRepository: ref.read(foodCategoryRepositoryProvider),
  ),
);

class CreateFoodCategoryUseCase {
  final FoodCategoryRepository _foodCategoryRepository;
  CreateFoodCategoryUseCase({
    required FoodCategoryRepository foodCategoryRepository,
  }) : _foodCategoryRepository = foodCategoryRepository;

  Future<UseCaseResult<FoodCategoryModel>> call({
    required String userId,
    required String name,
  }) async {
    final RepositoryResult<FoodCategoryEntity> result =
        await _foodCategoryRepository.createFoodCategory(
      userId: userId,
      name: name,
    );
    return switch (result) {
      SuccessRepositoryResult<FoodCategoryEntity>() =>
        SuccessUseCaseResult<FoodCategoryModel>(
          data: FoodCategoryModel.fromEntity(result.data),
        ),
      FailureRepositoryResult<FoodCategoryEntity>() =>
        FailureUseCaseResult<FoodCategoryModel>(
          message: result.messages?[0],
        )
    };
  }
}
