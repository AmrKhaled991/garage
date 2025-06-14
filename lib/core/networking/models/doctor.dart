import 'package:garage/core/networking/base/decodable.dart';
import 'package:garage/core/networking/models/category.dart';

class Doctor extends Decodable<Doctor> {
  Doctor({
    this.id,
    this.image,
    this.name,
    this.specialization,
    this.subcategories,
    this.address,
    this.lat,
    this.lng,
    this.desc,
    this.showPrice,
    this.rate,
    this.rateCount,
    this.services,
  });

  Doctor.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    specialization = json['specialization'];
    if (json['subcategories'] != null) {
      subcategories = [];
      json['subcategories'].forEach((v) {
        subcategories?.add(Category.fromJson(v));
      });
    }
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    desc = json['desc'];
    bio = json['bio'];
    showPrice = json['show_price'];
    rate = json['rate'];
    rateCount = json['rate_count'];
    if (json['services'] != null) {
      services = [];
      json['services'].forEach((v) {
        services?.add(Services.fromJson(v));
      });
    }
    if (json['certificates'] != null) {
      certificates = [];
      json['certificates'].forEach((v) {
        certificates?.add(Certificates.fromJson(v));
      });
    }
  }
  num? id;
  String? image;
  String? name;
  String? specialization;
  List<Category>? subcategories;
  String? address;
  String? lat;
  String? lng;
  String? desc;
  String? bio;
  bool? showPrice;
  num? rate;
  num? rateCount;
  List<Services>? services;
  List<Certificates>? certificates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['name'] = name;
    map['specialization'] = specialization;
    if (subcategories != null) {
      map['subcategories'] = subcategories?.map((v) => v.toJson()).toList();
    }
    map['address'] = address;
    map['lat'] = lat;
    map['lng'] = lng;
    map['desc'] = desc;
    map['bio'] = bio;
    map['show_price'] = showPrice;
    map['rate'] = rate;
    map['rate_count'] = rateCount;
    if (services != null) {
      map['services'] = services?.map((v) => v.toJson()).toList();
    }
    if (certificates != null) {
      map['certificates'] = certificates?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  Doctor decode(json) {
    return Doctor.fromJson(json);
  }
}

class Certificates {
  Certificates({this.id, this.path, this.extension, this.description});

  Certificates.fromJson(dynamic json) {
    id = json['id'];
    path = json['path'];
    extension = json['extension'];
    description = json['description'];
  }
  num? id;
  String? path;
  String? extension;
  dynamic description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['path'] = path;
    map['extension'] = extension;
    map['description'] = description;
    return map;
  }
}

class Services {
  Services({this.id, this.name, this.price});

  Services.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
  }
  num? id;
  String? name;
  num? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['price'] = price;
    return map;
  }
}
