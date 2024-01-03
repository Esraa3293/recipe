import 'package:flutter/material.dart';

class Recipe {
  final String? imagePath;
  final String? title;
  final String? mealType;
  final int? numOfCalories;
  final int? prepTime;
  final Icon? icon;

  const Recipe(
      {this.imagePath,
      this.title,
      this.mealType,
      this.numOfCalories,
      this.prepTime,
      this.icon});
}
