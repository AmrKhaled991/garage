import 'package:garage/core/networking/base/decodable.dart';

class Category extends Decodable<Category> {
  Category({
      this.id, 
      this.name, 
      this.image, 
      this.isActive,});

  Category.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    isActive = json['is_active'];
  }
  num? id;
  String? name;
  String? description;
  String? image;
  num? isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['image'] = image;
    map['is_active'] = isActive;
    return map;
  }

  @override
  Category decode(json) {
    return Category.fromJson(json);
  }

}