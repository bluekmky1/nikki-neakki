enum MealType {
  breakfast(name: '아침', value: 'breakfast'),
  lunch(name: '점심', value: 'lunch'),
  dinner(name: '저녁', value: 'dinner'),
  none(name: '없음', value: 'none');

  final String name;
  final String value;

  const MealType({required this.name, required this.value});

  static MealType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'breakfast' || '아침':
        return MealType.breakfast;
      case 'lunch' || '점심':
        return MealType.lunch;
      case 'dinner' || '저녁':
        return MealType.dinner;
      default:
        return MealType.none;
    }
  }
}
