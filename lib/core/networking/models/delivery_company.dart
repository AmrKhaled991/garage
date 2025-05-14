
import 'package:garage/core/networking/base/decodable.dart';

class DeliveryCompanyData extends Decodable<DeliveryCompanyData>{
  DeliveryCompanyData({
    this.id,
    this.image,
    this.title,
    this.phoneNumber,
    this.phoneWhatsapp,
    this.address,
    this.lat,
    this.long,
    this.createdAt,});

  DeliveryCompanyData.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    phoneNumber = json['phone_number'];
    phoneWhatsapp = json['phone_whatsapp'];
    address = json['address'];
    lat = json['lat'];
    long = json['long'];
    createdAt = json['created_at'];
  }
  int? id;
  String? image;
  String? title;
  String? phoneNumber;
  String? phoneWhatsapp;
  String? address;
  String? lat;
  String? long;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['title'] = title;
    map['phone_number'] = phoneNumber;
    map['phone_whatsapp'] = phoneWhatsapp;
    map['address'] = address;
    map['lat'] = lat;
    map['long'] = long;
    map['created_at'] = createdAt;
    return map;
  }

  @override
  DeliveryCompanyData decode(data) {
    return DeliveryCompanyData.fromJson(data);
  }

}