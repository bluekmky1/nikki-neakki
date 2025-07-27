import 'package:json_annotation/json_annotation.dart';

import '../../../domain/meal/model/meal_model.dart';
import '../entity/meal_entity.dart';

part 'generated/get_meals_with_category_names_response_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetMealsWithCategoryNamesResponseBody {
  final List<MealEntity> meals;
  final Map<String, String> categoryNames;

  const GetMealsWithCategoryNamesResponseBody({
    required this.meals,
    required this.categoryNames,
  });

  factory GetMealsWithCategoryNamesResponseBody.fromJson(
          Map<String, dynamic> json) =>
      _$GetMealsWithCategoryNamesResponseBodyFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetMealsWithCategoryNamesResponseBodyToJson(this);

  List<MealModel> toMealModels() => List<MealModel>.generate(
        meals.length,
        (int index) => MealModel.fromEntity(
          entity: meals[index],
          categoryNames: categoryNames,
        ),
      );
}
