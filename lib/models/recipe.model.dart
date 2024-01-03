class Recipe {
  String? imagePath;
  String? title;
  String? mealType;
  int? numOfCalories;
  int? prepTime;

  Recipe({
    this.imagePath,
    this.title,
    this.mealType,
    this.numOfCalories,
    this.prepTime,
  });

  Recipe.fromJson(Map<String, dynamic> data) {
    imagePath = data['imagePath'];
    title = data['title'];
    mealType = data['mealType'];
    numOfCalories = data['numOfCalories'];
    prepTime = data['prepTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      "imagePath": imagePath,
      "title": title,
      "mealType": mealType,
      "numOfCalories": numOfCalories,
      "prepTime": prepTime,
    };
  }
}
