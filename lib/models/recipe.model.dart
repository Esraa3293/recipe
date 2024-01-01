import 'package:flutter/material.dart';

class Recipe {
  final Color? color1;
  final Color? color2;
  final String? imagePath;
  final String? title;
  final String? mealType;
  final int? numOfCalories;
  final int? prepTime;
  final Icon? icon;

  const Recipe(
      {this.color1,
      this.color2,
      this.imagePath,
      this.title,
      this.mealType,
      this.numOfCalories,
      this.prepTime,
      this.icon});
}
