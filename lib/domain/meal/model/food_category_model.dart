import 'package:equatable/equatable.dart';

class FoodCategoryModel extends Equatable {
  final String id;
  final String name;

  const FoodCategoryModel({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        name,
      ];
}
