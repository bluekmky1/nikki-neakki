import 'package:equatable/equatable.dart';

import '../../../data/meal/entity/food_entity.dart';

class FoodModel extends Equatable {
  final String id;
  final String categoryId;
  final String name;

  const FoodModel({
    required this.id,
    required this.categoryId,
    required this.name,
  });

  factory FoodModel.fromEntity({
    required FoodEntity entity,
  }) =>
      FoodModel(
        id: entity.id,
        categoryId: entity.categoryId,
        name: entity.foodNote,
      );

  @override
  List<Object?> get props => <Object?>[
        id,
        categoryId,
        name,
      ];
}
