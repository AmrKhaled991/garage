import 'package:garage/core/networking/base/decodable.dart';

class PackageData extends Decodable<PackageData> {
  PackageData({
    this.id,
    this.title,
    this.description,
    this.price,
    this.duration,
    this.numberOfAds,
    this.numberOfImage,
    this.durationOfAds,
    this.isFree,
    this.createdAt,
  });

  PackageData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    duration = json['duration'];
    numberOfAds = json['number_of_ads'];
    numberOfImage = json['number_of_image'];
    durationOfAds = json['duration_of_ads'];
    isFree = json['is_free'];
    createdAt = json['created_at'];
  }
  int? id;
  String? title;
  String? description;
  String? price;
  int? duration;
  int? numberOfAds;
  int? numberOfImage;
  dynamic durationOfAds;
  int? isFree;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['price'] = price;
    map['duration'] = duration;
    map['number_of_ads'] = numberOfAds;
    map['number_of_image'] = numberOfImage;
    map['duration_of_ads'] = durationOfAds;
    map['is_free'] = isFree;
    map['created_at'] = createdAt;
    return map;
  }

  @override
  PackageData decode(data) {
    return PackageData.fromJson(data);
  }
}
