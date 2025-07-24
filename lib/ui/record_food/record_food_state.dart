import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/loading_status.dart';
import '../../domain/meal/model/food_model.dart';

class RecordFoodState extends Equatable {
  final LoadingStatus loadingStatus;
  // 음식 추가 화면
  final String selectedFoodCategory;
  final List<FoodModel> foods;
  // 카테고리 선택 바텀 시트
  final String searchKeyword;
  final List<String> allFoodCategories;
  final List<String> searchedFoodCategories;
  final XFile? pickedImage;

  const RecordFoodState({
    required this.loadingStatus,
    required this.selectedFoodCategory,
    required this.foods,
    required this.searchKeyword,
    required this.allFoodCategories,
    required this.searchedFoodCategories,
    required this.pickedImage,
  });

  const RecordFoodState.init()
      : loadingStatus = LoadingStatus.none,
        selectedFoodCategory = '',
        foods = const <FoodModel>[],
        searchKeyword = '',
        allFoodCategories = const <String>[
          '치킨',
          '햄버거',
          '카페',
          '빵',
          '피자',
          '피자11',
          '피자22',
          '피자33',
          '피자44',
          '피자55',
        ],
        searchedFoodCategories = const <String>[
          '치킨',
          '햄버거',
          '카페',
          '빵',
          '피자',
          '피자11',
          '피자22',
          '피자33',
          '피자44',
          '피자55',
        ],
        pickedImage = null;

  RecordFoodState copyWith({
    LoadingStatus? loadingStatus,
    String? selectedFoodCategory,
    List<FoodModel>? foods,
    String? searchKeyword,
    List<String>? allFoodCategories,
    List<String>? searchedFoodCategories,
    XFile? pickedImage,
  }) =>
      RecordFoodState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        selectedFoodCategory: selectedFoodCategory ?? this.selectedFoodCategory,
        foods: foods ?? this.foods,
        searchKeyword: searchKeyword ?? this.searchKeyword,
        allFoodCategories: allFoodCategories ?? this.allFoodCategories,
        searchedFoodCategories:
            searchedFoodCategories ?? this.searchedFoodCategories,
        pickedImage: pickedImage ?? this.pickedImage,
      );

  @override
  List<Object?> get props => <Object?>[
        loadingStatus,
        selectedFoodCategory,
        foods,
        searchKeyword,
        allFoodCategories,
        searchedFoodCategories,
        pickedImage,
      ];

  bool get canSave => foods.isNotEmpty;
}
