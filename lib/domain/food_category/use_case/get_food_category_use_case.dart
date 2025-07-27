import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/food_category/entity/food_category_entity.dart';
import '../../../data/food_category/food_category_repository.dart';
import '../model/food_category_model.dart';

final AutoDisposeProvider<GetFoodCategoryUseCase>
    getFoodCategoryUseCaseProvider =
    Provider.autoDispose<GetFoodCategoryUseCase>(
  (Ref<GetFoodCategoryUseCase> ref) => GetFoodCategoryUseCase(
    foodCategoryRepository: ref.read(foodCategoryRepositoryProvider),
  ),
);

class GetFoodCategoryUseCase {
  final FoodCategoryRepository _foodCategoryRepository;
  GetFoodCategoryUseCase({
    required FoodCategoryRepository foodCategoryRepository,
  }) : _foodCategoryRepository = foodCategoryRepository;

  Future<UseCaseResult<List<FoodCategoryModel>>> call({
    required String userId,
  }) async {
    final RepositoryResult<List<FoodCategoryEntity>> result =
        await _foodCategoryRepository.getFoodCategories(
      userId: userId,
    );
    return switch (result) {
      SuccessRepositoryResult<List<FoodCategoryEntity>>() =>
        SuccessUseCaseResult<List<FoodCategoryModel>>(
          data: List<FoodCategoryModel>.generate(
            result.data.length,
            (int index) => FoodCategoryModel.fromEntity(
              result.data[index],
            ),
          ),
        ),
      FailureRepositoryResult<List<FoodCategoryEntity>>() =>
        FailureUseCaseResult<List<FoodCategoryModel>>(
          message: result.messages?[0],
        )
    };
  }
}
