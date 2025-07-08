class Category {
  int? id;
  String? name;
  String? image;
  int? isActive;
  int? parentId;
  String? parentName;

  Category({
    this.id,
    this.name,
    this.image,
    this.isActive,
    this.parentId,
    this.parentName,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['id'] as int?,
    name: json['name'] as String?,
    image: json['image'] as String?,
    isActive: json['is_active'] as int?,
    parentId: json['parent_id'] as int?,
    parentName: json['parent_name'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'is_active': isActive,
    'parent_id': parentId,
    'parent_name': parentName,
  };
}
