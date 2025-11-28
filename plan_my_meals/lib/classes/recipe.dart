import 'ingredient.dart';
import '../enums/meal_category.dart';

class Recipe {
  final String name;
  final List<Ingredient> ingredients;
  final double? calories;
  final double? protein;
  final double? carbohydrates;
  final double? fats;
  final MealCategory? category;

  Recipe({
    required this.name,
    required this.ingredients,
    this.calories,
    this.protein,
    this.carbohydrates,
    this.fats,
    this.category,
  });
}