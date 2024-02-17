class Ad {
  String? title;
  String? imageUrl;

  Ad();

  Ad.fromJson(Map<String, dynamic> data) {
    title = data['title'];
    imageUrl = data['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    return {"title": title, "imageUrl": imageUrl};
  }
}
