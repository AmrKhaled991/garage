import 'dart:ffi';

import 'package:garage/core/networking/base/decodable.dart';

class UserAddress extends Decodable<UserAddress> {
  int? id;
  String? description;
  String? title;
  String? extraDescription;
  bool? isDefault;
  bool? isActive;
  String? lat;
  String? lng;

  UserAddress({
    this.id,
    this.title,
    this.description,
    this.extraDescription,
    this.isDefault,
    this.isActive,
    this.lat,
    this.lng,
  });

  UserAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    description = json['description'] as String?;
    title = json['title'] as String?;
    extraDescription = json['extra_description'] as String?;
    isDefault = json['is_default'] as bool?;
    isActive = json['is_active'] as bool?;
    lat = json['lat'] as String?;
    lng = json['lng'] as String?;
  }

  @override
  UserAddress decode(json) {
    // TODO: implement decode
    return UserAddress.fromJson(json);
  }
}
