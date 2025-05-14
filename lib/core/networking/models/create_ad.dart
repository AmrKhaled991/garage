
import 'package:garage/core/networking/base/decodable.dart';

class CreateAd extends Decodable<CreateAd>{
  CreateAd({
    this.id,
    this.title,
    this.image,
    this.description,
    this.mobile,
    this.hidePrivateNumber,
    this.startAt,
    this.endAt,
    this.isPublish,
    this.duration,
    this.status,
    this.view,
    this.isPaid,
    this.type,
    this.price,
    this.addationTotal,
    this.adsPrice,
    this.total,
    this.userType,
    this.createdAt,
    this.subscription,
    this.addations,
    this.attachs,
    this.address,});

  CreateAd.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    image = json['image'] != null ? ImageData.fromJson(json['image']) : null;
    description = json['description'];
    mobile = json['mobile'];
    hidePrivateNumber = json['hide_private_number'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    isPublish = json['is_publish'];
    duration = json['duration'];
    status = json['status'];
    view = json['view'];
    isPaid = json['is_paid'];
    type = json['type'];
    price = json['price'];
    addationTotal = json['addation_total'];
    adsPrice = json['ads_price'];
    total = json['total'];
    userType = json['user_type'];
    createdAt = json['created_at'];
    subscription = json['subscription'];
    // if (json['addations'] != null) {
    //   addations = [];
    //   json['addations'].forEach((v) {
    //     addations?.add(dynamic.fromJson(v));
    //   });
    // }
    // if (json['attachs'] != null) {
    //   attachs = [];
    //   json['attachs'].forEach((v) {
    //     attachs?.add(dynamic.fromJson(v));
    //   });
    // }
    if (json['address'] != null) {
      address = [];
      json['address'].forEach((v) {
        address?.add(Address.fromJson(v));
      });
    }
  }
  int? id;
  String? title;
  ImageData? image;
  String? description;
  String? mobile;
  dynamic hidePrivateNumber;
  String? startAt;
  String? endAt;
  dynamic isPublish;
  dynamic duration;
  dynamic status;
  dynamic view;
  dynamic isPaid;
  dynamic type;
  dynamic price;
  dynamic addationTotal;
  dynamic adsPrice;
  dynamic total;
  dynamic userType;
  String? createdAt;
  dynamic subscription;
  List<dynamic>? addations;
  List<dynamic>? attachs;
  List<Address>? address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    if (image != null) {
      map['image'] = image?.toJson();
    }
    map['description'] = description;
    map['mobile'] = mobile;
    map['hide_private_number'] = hidePrivateNumber;
    map['start_at'] = startAt;
    map['end_at'] = endAt;
    map['is_publish'] = isPublish;
    map['duration'] = duration;
    map['status'] = status;
    map['view'] = view;
    map['is_paid'] = isPaid;
    map['type'] = type;
    map['price'] = price;
    map['addation_total'] = addationTotal;
    map['ads_price'] = adsPrice;
    map['total'] = total;
    map['user_type'] = userType;
    map['created_at'] = createdAt;
    map['subscription'] = subscription;
    // if (addations != null) {
    //   map['addations'] = addations?.map((v) => v.toJson()).toList();
    // }
    // if (attachs != null) {
    //   map['attachs'] = attachs?.map((v) => v.toJson()).toList();
    // }
    if (address != null) {
      map['address'] = address?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  CreateAd decode(data) {
    return CreateAd.fromJson(data);
  }

}

class Address {
  Address({
    this.id,
    this.country,
    this.city,
    this.state,});

  Address.fromJson(dynamic json) {
    id = json['id'];
    country = json['country'] != null ? Country.fromJson(json['country']) : null;
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    state = json['state'] != null ? State.fromJson(json['state']) : null;
  }
  String? id;
  Country? country;
  City? city;
  State? state;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (country != null) {
      map['country'] = country?.toJson();
    }
    if (city != null) {
      map['city'] = city?.toJson();
    }
    if (state != null) {
      map['state'] = state?.toJson();
    }
    return map;
  }

}

class State {
  State({
    this.id,
    this.title,
    this.cityId,});

  State.fromJson(dynamic json) {
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

class City {
  City({
    this.id,
    this.title,});

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

class Country {
  Country({
    this.id,
    this.title,});

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

class ImageData {
  ImageData({
    this.id,
    this.url,
    this.mimeType,});

  ImageData.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
    mimeType = json['mime_type'];
  }
  dynamic id;
  String? url;
  String? mimeType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['url'] = url;
    map['mime_type'] = mimeType;
    return map;
  }

}