import 'package:garage/core/networking/base/decodable.dart';
import 'package:garage/core/networking/models/city.dart';
import 'package:garage/core/networking/models/user.dart';

class OfficeData extends Decodable<OfficeData> {
  OfficeData({
    this.id,
    this.title,
    this.description,
    this.image,
    this.mobile,
    this.status,
    this.socials,
    this.adsCount,
    this.country,
    this.city,
    this.state,
    this.user,
  });

  OfficeData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    mobile = json['mobile'];
    status = json['status'];
    if (json['socials'] != null) {
      socials = [];
      json['socials'].forEach((v) {
        socials?.add(Socials.fromJson(v));
      });
    }
    adsCount = json['ads_count'];
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    state = json['state'] != null ? StateData.fromJson(json['state']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  int? id;
  String? title;
  String? description;
  String? image;
  String? mobile;
  bool? status;
  List<Socials>? socials;
  int? adsCount;
  Country? country;
  City? city;
  StateData? state;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['image'] = image;
    map['mobile'] = mobile;
    map['status'] = status;
    if (socials != null) {
      map['socials'] = socials?.map((v) => v.toJson()).toList();
    }
    map['ads_count'] = adsCount;
    if (country != null) {
      map['country'] = country?.toJson();
    }
    if (city != null) {
      map['city'] = city?.toJson();
    }
    if (state != null) {
      map['state'] = state?.toJson();
    }
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

  @override
  OfficeData decode(data) {
    return OfficeData.fromJson(data);
  }
}

class Country {
  Country({this.id, this.title});

  Country.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
  }
  int? id;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    return map;
  }
}

class Socials {
  Socials({this.key, this.link});

  Socials.fromJson(dynamic json) {
    key = json['key'];
    link = json['link'];
  }
  String? key;
  String? link;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = key;
    map['link'] = link;
    return map;
  }
}
