class CategoryModel {
  String categoryName;
  String imageUrl;
  String id;

  CategoryModel({
    required this.categoryName,
    required this.imageUrl,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'categoryName': categoryName,
      'imageUrl': imageUrl,
      'id': id,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryName: json['categoryName'],
      imageUrl: json['imageUrl'],
      id: json['id'],
    );
  }
}
