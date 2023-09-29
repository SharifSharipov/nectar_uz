/* String categoryId;
  String categoryName;
  String description;
  String imageUrl;
  String createdAt;
*/
class CategoryModel {
  String categoryId;
  String categoryName;
  String description;
  String imageUrl;
  String createdAt;

  CategoryModel(
      {required this.categoryId,
      required this.categoryName,
      required this.description,
      required this.imageUrl,
      required this.createdAt});

  CategoryModel copyWith({
    String? catgoryId,
    String? categoryName,
    String? description,
    String? imageUrl,
    String? createdAt,
  }) {
    return CategoryModel(
        categoryId: catgoryId ?? this.categoryId,
        categoryName: categoryName ?? this.categoryName,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.description,
        createdAt: createdAt ?? this.createdAt);
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        categoryId: json["catgoryId"] as String? ??"",
        categoryName: json["categoryName"]as String? ??"",
        description: json["description"]as String? ??"",
        imageUrl: json["imageUrl"]as String? ??"",
        createdAt: json["createdAt"]as String? ??"");
  }

  Map<String, dynamic> toJson() => {
        "catgoryId": categoryId,
        "categoryName": categoryName,
        "description": description,
        "imageUrl": imageUrl,
        "createdAt": createdAt
      };
  @override
  String toString(){
    return """
     "catgoryId": $categoryId,
        "categoryName": $categoryName,
        "description": $description,
        "imageUrl": $imageUrl,
        "createdAt": $createdAt
    """;
  }
}
