import 'package:garage/core/networking/base/decodable.dart';

class User extends Decodable<User> {
  User({
    this.id,
    this.name,
    this.email,
    this.countryCode,
    this.phone,
    this.fullPhone,
    this.image,
    this.idImage,
    this.lang,
    this.isNotify,
    this.token,
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    countryCode = json['country_code'];
    phone = json['phone'];
    fullPhone = json['full_phone'];
    image = json['image'];
    idImage = json['id_image'];
    lang = json['lang'];
    isNotify = json['is_notify'];
    isActive = json['is_active'] ?? true;
    type = json['type'];
    token = json['token'];
  }
  num? id;
  String? name;
  String? email;
  String? countryCode;
  String? phone;
  String? fullPhone;
  String? image;
  String? idImage;
  String? lang;
  bool? isNotify;
  bool? isActive;
  String? type;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['country_code'] = countryCode;
    map['phone'] = phone;
    map['full_phone'] = fullPhone;
    map['image'] = image;
    map['id_image'] = idImage;
    map['lang'] = lang;
    map['is_notify'] = isNotify;
    map['is_active'] = isActive;
    map['type'] = type;
    map['token'] = token;
    return map;
  }

  @override
  User decode(data) {
    return User.fromJson(data);
  }
}
