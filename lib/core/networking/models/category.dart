// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:garage/core/networking/base/decodable.dart';

class Category extends Decodable<Category> {
  num? id;
  String? name;
  String? image;
  String? parent_name;
  num? isActive;
  num? parent_id;
  Category({
    this.id,
    this.name,
    this.image,
    this.parent_name,
    this.isActive,
    this.parent_id,
  });

  /*************  ✨ Windsurf Command ⭐  *************/
  /// Creates a copy of the [Category] but with the given fields replaced with
  /// the new values.
  ///
  /// If a field is not provided, it will keep its current value.
  ///
  /// A shallow copy is made, so the new [Category] instance will contain the
  /// same objects as this instance, just with the provided fields updated.
  /// *****  640d2a8b-6c66-4756-8723-b64550a55bbe  ******
  Category copyWith({
    num? id,
    String? name,
    String? image,
    String? parent_name,
    num? isActive,
    num? parent_id,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      parent_name: parent_name ?? this.parent_name,
      isActive: isActive ?? this.isActive,
      parent_id: parent_id ?? this.parent_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'parent_name': parent_name,
      'isActive': isActive,
      'parent_id': parent_id,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] != null ? map['id'] as num : null,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      parent_name:
          map['parent_name'] != null ? map['parent_name'] as String : null,
      isActive: map['isActive'] != null ? map['isActive'] as num : null,
      parent_id: map['parent_id'] != null ? map['parent_id'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Category(id: $id, name: $name, image: $image, parent_name: $parent_name, isActive: $isActive, parent_id: $parent_id)';
  }

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.image == image &&
        other.parent_name == parent_name &&
        other.isActive == isActive &&
        other.parent_id == parent_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        image.hashCode ^
        parent_name.hashCode ^
        isActive.hashCode ^
        parent_id.hashCode;
  }

  @override
  Category decode(json) {
    // TODO: implement decode
    return Category.fromMap(json);
  }
}
