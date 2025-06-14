import 'package:garage/core/networking/base/decodable.dart';

class SupportedCountry extends Decodable<SupportedCountry> {
  SupportedCountry({this.id, this.key, this.name, this.flag});

  SupportedCountry.fromJson(dynamic json) {
    id = json['id'];
    key = json['key'];
    name = json['name'];
    flag = json['flag'];
  }
  num? id;
  String? key;
  String? name;
  String? flag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['key'] = key;
    map['name'] = name;
    map['flag'] = flag;
    return map;
  }

  @override
  SupportedCountry decode(data) {
    return SupportedCountry.fromJson(data);
  }
}
