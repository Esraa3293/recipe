class Favorite {
  String? docId;
  String? imagePath;
  String? title;
  String? description;
  String? mealType;
  String? nutFacts;
  String? prepTime;
  int? serving;
  double? rating;
  List<String>? ingred;
  List<String>? favoriteUsersIds;

  Favorite({this.docId,
    this.imagePath,
    this.title,
    this.description,
    this.mealType,
    this.nutFacts,
    this.prepTime,
    this.serving,
    this.rating,
    this.ingred,
    this.favoriteUsersIds});

  Favorite.fromJson(Map<String, dynamic> data, [String? id]) {
    docId = id;
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
    favoriteUsersIds = data['favoriteUsersIds'] != null
        ? List<String>.from(data['favoriteUsersIds'].map((e) => e.toString()))
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "docId": docId,
      "imagePath": imagePath,
      "title": title,
      "description": description,
      "mealType": mealType,
      "numOfCalories": nutFacts,
      "prepTime": prepTime,
      "serving": serving,
      "rating": rating,
      "ingred": ingred,
      "favoriteUsersIds": favoriteUsersIds,
    };
  }
}
