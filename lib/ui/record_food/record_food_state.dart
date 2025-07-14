import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';

class RecordFoodState extends Equatable {
  final LoadingStatus loadingStatus;
  final List<String> foodCategories;

  const RecordFoodState({
    required this.loadingStatus,
    required this.foodCategories,
  });

  const RecordFoodState.init()
      : loadingStatus = LoadingStatus.none,
        foodCategories = const <String>[
          '피자',
          '치킨',
          '햄버거',
          '카페',
          '빵',
        ];

  RecordFoodState copyWith({
    LoadingStatus? loadingStatus,
    List<String>? foodCategories,
  }) =>
      RecordFoodState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        foodCategories: foodCategories ?? this.foodCategories,
      );

  @override
  List<Object> get props => <Object>[
        loadingStatus,
        foodCategories,
      ];
}
