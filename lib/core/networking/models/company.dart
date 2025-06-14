import 'package:garage/core/networking/base/decodable.dart';
import 'package:garage/core/networking/models/category.dart';
import 'package:garage/core/networking/models/city.dart';

class CompanyData extends Decodable<CompanyData> {
  CompanyData({
    this.id,
    this.name,
    this.image,
    this.email,
    this.phoneCode,
    this.mobile,
    this.isActive,
    this.type,
    this.numberOfFree,
    this.isVerified,
    this.adminVerified,
    this.company,
    this.firebaseUuid,
    this.adsCount,
  });

  CompanyData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    email = json['email'];
    phoneCode = json['phone_code'];
    mobile = json['mobile'];
    isActive = json['is_active'];
    type = json['type'];
    numberOfFree = json['number_of_free'];
    isVerified = json['is_verified'];
    adminVerified = json['admin_verified'];
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
    firebaseUuid = json['firebase_uuid'];
    adsCount = json['ads_count'];
  }
  int? id;
  String? name;
  String? image;
  String? email;
  String? phoneCode;
  String? mobile;
  dynamic isActive;
  String? type;
  String? numberOfFree;
  dynamic isVerified;
  dynamic adminVerified;
  Company? company;
  dynamic firebaseUuid;
  dynamic adsCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['email'] = email;
    map['phone_code'] = phoneCode;
    map['mobile'] = mobile;
    map['is_active'] = isActive;
    map['type'] = type;
    map['number_of_free'] = numberOfFree;
    map['is_verified'] = isVerified;
    map['admin_verified'] = adminVerified;
    if (company != null) {
      map['company'] = company?.toJson();
    }
    map['firebase_uuid'] = firebaseUuid;
    map['ads_count'] = adsCount;
    return map;
  }

  @override
  CompanyData decode(data) {
    return CompanyData.fromJson(data);
  }
}

class Company {
  Company({
    this.id,
    this.title,
    this.descriptionWork,
    this.document,
    this.cover,
    this.deliveryReceive,
    this.socials,
    this.categories,
    this.state,
    this.city,
    this.address,
  });

  Company.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    descriptionWork = json['description_work'];
    document = json['document'];
    cover = json['cover'];
    deliveryReceive = json['delivery_receive'];
    address = json['address'];
    if (json['socials'] != null) {
      socials = [];
      json['socials'].forEach((v) {
        socials?.add(Socials.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(Category.fromJson(v));
      });
    }
    state = json['state'] != null ? StateData.fromJson(json['state']) : null;
    city = json['city'] != null ? City.fromJson(json['city']) : null;
  }
  int? id;
  String? title;
  String? descriptionWork;
  String? document;
  String? cover;
  String? address;
  dynamic deliveryReceive;
  List<Socials>? socials;
  List<Category>? categories;
  StateData? state;
  City? city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description_work'] = descriptionWork;
    map['document'] = document;
    map['cover'] = cover;
    map['delivery_receive'] = deliveryReceive;
    map['address'] = address;
    if (socials != null) {
      map['socials'] = socials?.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    if (state != null) {
      map['state'] = state?.toJson();
    }
    if (city != null) {
      map['city'] = city?.toJson();
    }
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

class City {
  City({this.id, this.title});

  City.fromJson(dynamic json) {
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

class CompanyState {
  CompanyState({this.id, this.title, this.cityId});

  CompanyState.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    cityId = json['city_id'];
  }
  int? id;
  String? title;
  int? cityId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['city_id'] = cityId;
    return map;
  }
}

class Categories {
  Categories({
    this.id,
    this.color,
    this.image,
    this.isEndCategory,
    this.slimDetails,
    this.type,
    this.title,
  });

  Categories.fromJson(dynamic json) {
    id = json['id'];
    color = json['color'];
    image = json['image'];
    isEndCategory = json['is_end_category'];
    slimDetails = json['slim_details'];
    type = json['type'];
    title = json['title'];
  }
  int? id;
  String? color;
  String? image;
  dynamic isEndCategory;
  dynamic slimDetails;
  String? type;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['color'] = color;
    map['image'] = image;
    map['is_end_category'] = isEndCategory;
    map['slim_details'] = slimDetails;
    map['type'] = type;
    map['title'] = title;
    return map;
  }
}
