import 'package:equatable/equatable.dart';

import '../../../data/meal_mate/entity/meal_mate_entity.dart';

class MealMateModel extends Equatable {
  final String id;
  final String user1Id;
  final String user2Id;
  final DateTime createdAt;

  const MealMateModel({
    required this.id,
    required this.user1Id,
    required this.user2Id,
    required this.createdAt,
  });

  factory MealMateModel.fromEntity({required MealMateEntity? entity}) =>
      MealMateModel(
        id: entity?.id ?? '',
        user1Id: entity?.user1Id ?? '',
        user2Id: entity?.user2Id ?? '',
        createdAt: entity?.createdAt ?? DateTime.now(),
      );

  @override
  List<Object?> get props => <Object?>[
        id,
        user1Id,
        user2Id,
        createdAt,
      ];
}
