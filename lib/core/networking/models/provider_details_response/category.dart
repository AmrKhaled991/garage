class Category {
  int? id;
  String? name;
  String? image;
  int? isActive;

  Category({this.id, this.name, this.image, this.isActive});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['id'] as int?,
    name: json['name'] as String?,
    image: json['image'] as String?,
    isActive: json['is_active'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'is_active': isActive,
  };
}
