enum MealType {
  breakfast(name: '아침'),
  lunch(name: '점심'),
  dinner(name: '저녁'),
  none(name: '없음');

  final String name;

  const MealType({required this.name});

  static MealType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'breakfast':
        return MealType.breakfast;
      case 'lunch':
        return MealType.lunch;
      case 'dinner':
        return MealType.dinner;
      default:
        return MealType.none;
    }
  }
}
