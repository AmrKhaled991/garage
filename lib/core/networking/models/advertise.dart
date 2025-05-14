
import 'package:garage/core/networking/base/decodable.dart';

class Advertise extends Decodable<Advertise> {
  Advertise({
    this.id,
    this.image,
    this.link,
    this.type,
    this.adsId,});

  Advertise.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    link = json['link'];
    type = json['type'];
    adsId = json['ads_id'];
  }
  int? id;
  String? image;
  String? link;
  String? type;
  dynamic adsId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['link'] = link;
    map['type'] = type;
    map['ads_id'] = adsId;
    return map;
  }

  @override
  Advertise decode(data) {
    return Advertise.fromJson(data);
  }

}