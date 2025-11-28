import 'ingredient.dart';
import '../enums/meal_category.dart';

class Recipe {
  final String name;
  final int portions;
  final String instructions;
  final List<Ingredient> ingredients;
  final double calories;
  final double protein;
  final double carbohydrates;
  final double fats;
  final MealCategory category;
  final String? licenseInfo;
  final String? source;

  Recipe({
    required this.name,
    required this.ingredients,
    required this.calories,
    required this.protein,
    required this.carbohydrates,
    required this.fats,
    required this.category,
    this.licenseInfo,
    this.source,
    required this.portions,
    required this.instructions,
  });
}