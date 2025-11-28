// ignore_for_file: prefer_final_fields

import 'package:plan_my_meals/enums/user_group.dart';
import 'package:plan_my_meals/enums/activity_level.dart';
import 'package:plan_my_meals/enums/body_type.dart';
import 'package:plan_my_meals/enums/gender.dart';
import 'package:plan_my_meals/enums/diet_preference.dart';
import 'package:plan_my_meals/enums/macro_nutrient.dart';

class UserProfile {
	String name;
	int _weight; // in kilograms
	int _height; // in centimeters
	int _age; // in years
	UserGroup userGroup;
	ActivityLevel activityLevel;
	BodyType bodyType;
	Gender gender;
	int _mealsPerDay;
	List<DietPreference> dietPreferences;
	late int dailyCaloricNeeds;
	late Map<MacroNutrient, int> macroNutrientNeeds;
	
	UserProfile({
		required this.name,
		required int weight,
		required int height,
		required int age,
		required this.userGroup,
		required this.activityLevel,
		required this.bodyType,
		required this.gender,
		required int mealsPerDay,
		required this.dietPreferences,
		required this.dailyCaloricNeeds,
		required this.macroNutrientNeeds,
	}) : _weight = weight,
		 _height = height,
		 _age = age,
		 _mealsPerDay = mealsPerDay;

	int get weight => _weight;
	int get height => _height;
	int get age => _age;
	int get mealsPerDay => _mealsPerDay;
	int get dailyCalories => dailyCaloricNeeds;
	Map<MacroNutrient, int> get macroNutrients => macroNutrientNeeds;

	set weight(int value) {
		if (value < 30 || value > 500) {
			throw ArgumentError("Weight must be between 30 and 500.");
		}
		_weight = value;
	}

	set height(int value) {
		if (value <= 100 || value > 300) {
			throw ArgumentError("Height must be greater than 100 and less than or equal to 300.");
		}
		_height = value;
	}

	set age(int value) {
		if (value < 12 || value > 120) {
			throw ArgumentError("Age must be between 12 and 120.");
		}
		_age = value;
	}

	set mealsPerDay(int value) {
		if (value < 1 || value > 5) {
			throw ArgumentError("Meals per day must be between 1 and 5.");
		}
		_mealsPerDay = value;
	}

	int calculateDailyCaloricNeeds() {
		final w = weight.toDouble();
		final h = height.toDouble();
		final a = age.toDouble();		

		double bmr;
		if (gender == Gender.male) {
			bmr = 13.397 * w + 4.799 * h - 5.677 * a + 88.362;
		} else {
			bmr = 9.247 * w + 3.098 * h - 4.330 * a + 447.593;
		}

		switch(activityLevel) {
			case ActivityLevel.sedentary:
				dailyCaloricNeeds = (bmr * 1.2).round();
				break;
			case ActivityLevel.lightlyActive:
				dailyCaloricNeeds = (bmr * 1.375).round();
				break;
			case ActivityLevel.moderatelyActive:
				dailyCaloricNeeds = (bmr * 1.55).round();
				break;
			case ActivityLevel.veryActive:
				dailyCaloricNeeds = (bmr * 1.725).round();
				break;
		}

		return dailyCaloricNeeds;
	}
	
	Map<MacroNutrient, int> calculateMacroNutrientNeeds() {
		//sedentary 15% protein / 55% carbs / 30% fats
		//lightly active 20% protein / 50% carbs / 30% fats
		//moderately active 25% protein / 45% carbs / 30% fats
		//very active 30% protein / 40% carbs / 30% fats

		int proteinCalories;
		int carbCalories;
		int fatCalories;

		if (dietPreferences.contains(DietPreference.keto)) {
			proteinCalories = (dailyCaloricNeeds * 25 / 100).round();
			carbCalories = (dailyCaloricNeeds * 5 / 100).round();
			fatCalories = (dailyCaloricNeeds * 70 / 100).round();
		} else if (dietPreferences.contains(DietPreference.lowCarb)) {
			proteinCalories = (dailyCaloricNeeds * 30 / 100).round();
			carbCalories = (dailyCaloricNeeds * 20 / 100).round();
			fatCalories = (dailyCaloricNeeds * 50 / 100).round();
		} else if (dietPreferences.contains(DietPreference.highProtein)) {
			proteinCalories = (dailyCaloricNeeds * 40 / 100).round();
			carbCalories = (dailyCaloricNeeds * 40 / 100).round();
			fatCalories = (dailyCaloricNeeds * 20 / 100).round();
		} else {
			switch(activityLevel) {
				case ActivityLevel.sedentary:
					proteinCalories = (dailyCaloricNeeds * 0.15).round();
					carbCalories = (dailyCaloricNeeds * 0.55).round();
					fatCalories = (dailyCaloricNeeds * 0.30).round();
					break;
				case ActivityLevel.lightlyActive:
					proteinCalories = (dailyCaloricNeeds * 0.20).round();
					carbCalories = (dailyCaloricNeeds * 0.50).round();
					fatCalories = (dailyCaloricNeeds * 0.30).round();
					break;
				case ActivityLevel.moderatelyActive:
					proteinCalories = (dailyCaloricNeeds * 0.25).round();
					carbCalories = (dailyCaloricNeeds * 0.45).round();
					fatCalories = (dailyCaloricNeeds * 0.30).round();
					break;
				case ActivityLevel.veryActive:
					proteinCalories = (dailyCaloricNeeds * 0.30).round();
					carbCalories = (dailyCaloricNeeds * 0.40).round();
					fatCalories = (dailyCaloricNeeds * 0.30).round();
					break;
			}
		}
		return {
			MacroNutrient.protein: (proteinCalories / 4).round(),
			MacroNutrient.carbohydrates: (carbCalories / 4).round(),
			MacroNutrient.fats: (fatCalories / 9).round()
		};
	}
}