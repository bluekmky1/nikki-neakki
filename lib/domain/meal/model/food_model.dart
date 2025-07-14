import 'package:equatable/equatable.dart';

class FoodModel extends Equatable {
  final String id;
  final String category;
  final String name;

  const FoodModel({
    required this.id,
    required this.category,
    required this.name,
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
        category,
        name,
      ];
}
