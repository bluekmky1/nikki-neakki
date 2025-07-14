import 'package:equatable/equatable.dart';
import '../../../ui/common/consts/meal_type.dart';
import 'food_model.dart';

class MealModel extends Equatable {
  final String id;
  final String thumbnailUrl;
  final DateTime mealTime;
  final MealType mealType;
  final List<FoodModel> foods;

  const MealModel({
    required this.id,
    required this.thumbnailUrl,
    required this.mealTime,
    required this.mealType,
    required this.foods,
  });

  // factory ExampleModel.fromEntity({
  //   required ExampleEntity entity,
  // }) =>
  //     ExampleModel(
  //       id: entity.id,
  //       title: entity.title,
  //     );

  @override
  List<Object?> get props => <Object?>[
        id,
        thumbnailUrl,
        mealTime,
        mealType,
        foods,
      ];
}
