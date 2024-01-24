class Recipe {
  String? imagePath;
  String? title;
  String? description;
  String? mealType;
  String? nutFacts;
  String? prepTime;
  int? serving;
  int? rating;
  List<String>? ingred;

  Recipe(
      {this.imagePath,
      this.title,
      this.description,
      this.mealType,
      this.nutFacts,
      this.prepTime,
      this.serving,
      this.rating,
      this.ingred});

  Recipe.fromJson(Map<String, dynamic> data) {
    imagePath = data['imagePath'];
    title = data['title'];
    description = data['description'];
    mealType = data['mealType'];
    nutFacts = data['numOfCalories'];
    prepTime = data['prepTime'];
    serving = data['serving'];
    rating = data['rating'];
    ingred = data['ingred'] != null
        ? List<String>.from(data['ingred'].map((e) => e.toString()))
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "imagePath": imagePath,
      "title": title,
      "description": description,
      "mealType": mealType,
      "numOfCalories": nutFacts,
      "prepTime": prepTime,
      "serving": serving,
      "rating": rating,
      "ingred": ingred,
    };
  }
}
