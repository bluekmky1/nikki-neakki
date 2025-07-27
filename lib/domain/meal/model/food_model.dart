import 'package:equatable/equatable.dart';

import '../../../data/meal/entity/food_entity.dart';

class FoodModel extends Equatable {
  final String id;
  final String categoryName;
  final String name;

  const FoodModel({
    required this.id,
    required this.categoryName,
    required this.name,
  });

  factory FoodModel.fromEntity({
    required FoodEntity entity,
    Map<String, String>? categoryNames,
  }) =>
      FoodModel(
        id: entity.id,
        categoryName: categoryNames?[entity.categoryId] ?? '알 수 없음',
        name: entity.foodNote,
      );

  @override
  List<Object?> get props => <Object?>[
        id,
        categoryName,
        name,
      ];
}
