enum DietType {
  omnivore,
  vegetarian,
  vegan,
  pescatarian,
}

class QuizModel {
  final List<String> allergens; // ['gluten', 'lactose', ...]
  final DietType dietType;
  final int meatMealsPerWeek;
  final int fishMealsPerWeek;

  QuizModel({
    required this.allergens,
    required this.dietType,
    required this.meatMealsPerWeek,
    required this.fishMealsPerWeek,
  });

  Map<String, dynamic> toJson() {
    return {
      'allergens': allergens,
      'diet_type': dietType.name,
      'meat_meals_per_week': meatMealsPerWeek,
      'fish_meals_per_week': fishMealsPerWeek,
    };
  }

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    final dietString = json['diet_type'] as String? ?? 'omnivore';
    return QuizModel(
      allergens: List<String>.from(json['allergens'] ?? const []),
      dietType: DietType.values.firstWhere(
        (d) => d.name == dietString,
        orElse: () => DietType.omnivore,
      ),
      meatMealsPerWeek: (json['meat_meals_per_week'] ?? 0) as int,
      fishMealsPerWeek: (json['fish_meals_per_week'] ?? 0) as int,
    );
  }
}
