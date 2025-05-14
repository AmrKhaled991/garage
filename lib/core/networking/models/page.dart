
import 'package:garage/core/networking/base/decodable.dart';

class PagesData extends Decodable<PagesData>{
  PagesData({
    this.id,
    this.title,
    this.description,});

  PagesData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }
  int? id;
  String? title;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    return map;
  }

  @override
  PagesData decode(data) {
    return PagesData.fromJson(data);
  }

}