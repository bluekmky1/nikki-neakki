enum MealType {
  breakfast(name: '아침'),
  lunch(name: '점심'),
  dinner(name: '저녁');

  final String name;

  const MealType({required this.name});
}
