import 'package:garage/core/networking/base/decodable.dart';

class Offer extends Decodable<Offer> {
  Offer({this.id, this.title, this.description, this.image});

  Offer.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
  }
  num? id;
  String? title;
  String? description;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['image'] = image;
    return map;
  }

  @override
  Offer decode(json) {
    return Offer.fromJson(json);
  }
}
