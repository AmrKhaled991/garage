
import 'package:garage/core/networking/base/decodable.dart';

class Addation extends Decodable<Addation>{
  Addation({
    this.id,
    this.name,
    this.icon,
    this.price,
    this.type,
    this.description});

  Addation.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    price = json['price'].toDouble();
    type = json['type'];
    description = json['description'];
  }
  int? id;
  String? name;
  String? icon;
  String? description;
  double? price;
  int? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['icon'] = icon;
    map['price'] = price;
    map['type'] = type;
    map['description'] = description;
    return map;
  }

  @override
  Addation decode(data) {
    return Addation.fromJson(data);
  }

}