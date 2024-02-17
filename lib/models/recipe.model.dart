class Recipe {
  String? docId;
  bool? isFresh;
  String? imageUrl;
  String? title;
  String? description;
  String? mealType;
  int? prepTime;
  int? calories;
  int? serving;
  num? rate;
  List<String>? ingred;
  List<String>? favoriteUsersIds;
  List<String>? recentlyViewedUsersIds;
  List<String>? directions;

  Recipe(
      {this.docId,
      this.isFresh,
      this.imageUrl,
      this.title,
      this.description,
      this.mealType,
      this.prepTime,
      this.calories,
      this.serving,
      this.rate,
      this.ingred,
      this.favoriteUsersIds,
      this.recentlyViewedUsersIds,
      this.directions});

  Recipe.fromJson(Map<String, dynamic> data, [String? id]) {
    docId = id;
    isFresh = data['isFresh'];
    imageUrl = data['imageUrl'];
    title = data['title'];
    description = data['description'];
    mealType = data['mealType'];
    calories = data['calories'];
    prepTime = data['prepTime'];
    serving = data['serving'];
    rate = data['rate'];
    ingred = data['ingred'] != null
        ? List<String>.from(data['ingred'].map((e) => e.toString()))
        : null;
    favoriteUsersIds = data['favoriteUsersIds'] != null
        ? List<String>.from(data['favoriteUsersIds'].map((e) => e.toString()))
        : null;
    recentlyViewedUsersIds = data['recentlyViewedUsersIds'] != null
        ? List<String>.from(
            data['recentlyViewedUsersIds'].map((e) => e.toString()))
        : null;
    directions = data['directions'] != null
        ? List<String>.from(data['directions'].map((e) => e.toString()))
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "docId": docId,
      "isFresh": isFresh,
      "imageUrl": imageUrl,
      "title": title,
      "description": description,
      "mealType": mealType,
      "prepTime": prepTime,
      "calories": calories,
      "serving": serving,
      "rate": rate,
      "ingred": ingred,
      "favoriteUsersIds": favoriteUsersIds,
      "recentlyViewedUsersIds": recentlyViewedUsersIds,
      "directions": directions
    };
  }
}
