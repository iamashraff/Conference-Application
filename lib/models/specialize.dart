class Specialize {
  int? id;
  String area;
  String description;
  String imageUrl;

  Specialize(
      {this.id,
      required this.area,
      required this.description,
      required this.imageUrl});

  Specialize.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        area = res["area"],
        description = res["description"],
        imageUrl = res["imageUrl"];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'area': area,
      'description': description,
      'imageUrl': imageUrl
    };
  }
}
