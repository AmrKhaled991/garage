import 'package:garage/core/networking/base/decodable.dart';

class GarageSocials extends Decodable<GarageSocials> {
  String? link;
  String? name;
  String? icon;

  GarageSocials({this.link, this.name, this.icon});

  GarageSocials.fromJson(dynamic json) {
    link = json['link'];
    name = json['name'];
    icon = json['icon'];
  }

  @override
  GarageSocials decode(json) {
    // TODO: implement decode
    return GarageSocials.fromJson(json);
  }
}
