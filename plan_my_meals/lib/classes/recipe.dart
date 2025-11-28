import 'ingredient.dart';
import '../enums/meal_category.dart';
import 'nutrition.dart';

class Recipe {
  final String name;
  final int portions;
  final String instructions;
  final List<Ingredient> ingredients;
  final int calories;
  final int protein;
  final int carbohydrates;
  final int fats;
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