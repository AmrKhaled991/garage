import 'package:garage/core/networking/base/decodable.dart';

class SliderData extends Decodable {
  SliderData({
    this.id,
    this.image,
    this.link,
    this.type,
    this.adsId,
    this.position,
  });

  SliderData.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    link = json['link'];
    type = json['type'];
    target = json['target'];
    adsId = json['ads_id'];
    position = json['position'];
  }
  int? id;
  String? image;
  dynamic link;
  String? type;
  String? target;
  dynamic adsId;
  String? position;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['link'] = link;
    map['type'] = type;
    map['target'] = target;
    map['ads_id'] = adsId;
    map['position'] = position;
    return map;
  }

  @override
  decode(data) {
    return SliderData.fromJson(data);
  }
}
