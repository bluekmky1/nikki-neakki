import 'package:equatable/equatable.dart';

import '../../../data/food_category/entity/food_category_entity.dart';

class FoodCategoryModel extends Equatable {
  final String id;
  final String name;
  final DateTime createdAt;

  const FoodCategoryModel({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory FoodCategoryModel.fromEntity(FoodCategoryEntity entity) =>
      FoodCategoryModel(
        id: entity.id,
        name: entity.name,
        createdAt: entity.createdAt,
      );

  FoodCategoryModel copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
  }) =>
      FoodCategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
      );

  @override
  List<Object> get props => <Object>[
        id,
        name,
        createdAt,
      ];
}
