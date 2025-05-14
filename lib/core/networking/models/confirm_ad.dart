import 'package:garage/core/networking/base/decodable.dart';
import 'package:garage/core/networking/models/ad.dart';

class ConfirmAd extends Decodable<ConfirmAd>{
  ConfirmAd({
    this.ads,
    this.url,});

  ConfirmAd.fromJson(dynamic json) {
    ads = json['ads'] != null ? AdData.fromJson(json['ads']) : null;
    url = json['url'];
  }
  AdData? ads;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (ads != null) {
      map['ads'] = ads?.toJson();
    }
    map['url'] = url;
    return map;
  }

  @override
  ConfirmAd decode(data) {
    return ConfirmAd.fromJson(data);
  }

}