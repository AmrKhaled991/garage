import 'package:garage/core/networking/base/decodable.dart';

class IntroSlider extends Decodable<IntroSlider> {
  IntroSlider({
    this.id,
    this.image,
    this.status,
    this.title,
    this.description,
    this.deletedAt,
    this.createdAt,
  });

  IntroSlider.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    status = json['status'];
    title = json['title'];
    description = json['description'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
  }
  num? id;
  String? image;
  num? status;
  String? title;
  String? description;
  dynamic deletedAt;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['status'] = status;
    map['title'] = title;
    map['description'] = description;
    map['deleted_at'] = deletedAt;
    map['created_at'] = createdAt;
    return map;
  }

  @override
  IntroSlider decode(data) {
    return IntroSlider.fromJson(data);
  }
}
