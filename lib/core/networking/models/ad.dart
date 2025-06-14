import 'package:garage/core/networking/base/decodable.dart';

import 'addations.dart';
import 'category.dart';
import 'city.dart';
import 'company.dart';

class AdData extends Decodable<AdData> {
  AdData({
    this.id,
    this.title,
    this.image,
    this.video,
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
    this.offerPrice,
    this.addationTotal,
    this.adsPrice,
    this.total,
    this.createdAt,
    this.user,
    this.category,
    this.addations,
    this.attributes,
    this.attachs,
    // this.country,
    this.address,
    this.seen,
    this.favoritesCount,
    this.size,
  });

  AdData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    image = json['image'] != null ? ImageItem.fromJson(json['image']) : null;
    video = json['video'] != null ? VideoItem.fromJson(json['video']) : null;
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
    offerPrice = json['offer_price'];
    addationTotal = json['addation_total'];
    adsPrice = json['ads_price'];
    total = json['total'];
    createdAt = json['created_at'];
    seen = json['seen'];
    favoritesCount = json['favorites_count'];
    size = json['size'];
    user = json['user'] != null ? CompanyData.fromJson(json['user']) : null;
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    if (json['addations'] != null) {
      addations = [];
      json['addations'].forEach((v) {
        addations?.add(Addations.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = [];
      json['attributes'].forEach((v) {
        attributes?.add(Attributes.fromJson(v));
      });
    }
    if (json['attachs'] != null) {
      attachs = [];
      json['attachs'].forEach((v) {
        attachs?.add(ImageItem.fromJson(v));
      });
    }
    // country = json['country'];
    if (json['address'] != null) {
      address = [];
      json['address'].forEach((v) {
        address?.add(Address.fromJson(v));
      });
    }
  }
  int? id;
  String? title;
  ImageItem? image;
  VideoItem? video;
  String? description;
  String? mobile;
  dynamic hidePrivateNumber;
  String? startAt;
  String? endAt;
  dynamic isPublish;
  String? duration;
  dynamic status;
  dynamic view;
  dynamic isPaid;
  String? type;
  dynamic? price;
  dynamic offerPrice;
  dynamic addationTotal;
  dynamic adsPrice;
  dynamic total;
  String? createdAt;
  CompanyData? user;
  Category? category;
  List<Addations>? addations;
  List<Attributes>? attributes;
  List<ImageItem>? attachs;
  // dynamic country;
  List<Address>? address;
  int? seen;
  int? favoritesCount;
  dynamic? size;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    if (image != null) {
      map['image'] = image?.toJson();
    }
    if (video != null) {
      map['video'] = video?.toJson();
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
    map['offer_price'] = offerPrice;
    map['addation_total'] = addationTotal;
    map['ads_price'] = adsPrice;
    map['total'] = total;
    map['created_at'] = createdAt;
    map['seen'] = seen;
    map['favorites_count'] = favoritesCount;
    map['size'] = size;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (category != null) {
      map['category'] = category?.toJson();
    }
    if (addations != null) {
      map['addations'] = addations?.map((v) => v.toJson()).toList();
    }
    if (attributes != null) {
      map['attributes'] = attributes?.map((v) => v.toJson()).toList();
    }
    if (attachs != null) {
      map['attachs'] = attachs?.map((v) => v.toJson()).toList();
    }
    // map['country'] = country;
    if (address != null) {
      map['address'] = address?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  AdData decode(data) {
    return AdData.fromJson(data);
  }
}

class Attributes {
  Attributes({this.id, this.attribute, this.option, this.value});

  Attributes.fromJson(dynamic json) {
    id = json['id'];
    attribute =
        json['attribute'] != null
            ? AdAttribute.fromJson(json['attribute'])
            : null;
    if (json['option'] != null) {
      option = Option.fromJson(json['option']);
    }
    value = json['value'];
  }
  String? id;
  AdAttribute? attribute;
  Option? option;
  dynamic? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (attribute != null) {
      map['attribute'] = attribute?.toJson();
    }
    map['option'] = option;
    map['value'] = value;
    return map;
  }
}

class Option {
  Option({this.id, this.value, this.isDefault});

  Option.fromJson(dynamic json) {
    id = json['id'];
    value = json['value'];
    isDefault = json['is_default'];
  }
  int? id;
  dynamic value;
  dynamic isDefault;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['value'] = value;
    map['is_default'] = isDefault;
    return map;
  }
}

class AdAttribute {
  AdAttribute({
    this.id,
    this.type,
    this.name,
    this.icon,
    this.allowFromTo,
    this.validation,
  });

  AdAttribute.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    icon = json['icon'];
    allowFromTo = json['allow_from_to'];
    validation =
        json['validation'] != null
            ? Validation.fromJson(json['validation'])
            : null;
  }
  int? id;
  String? type;
  String? name;
  String? icon;
  dynamic allowFromTo;
  Validation? validation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['name'] = name;
    map['icon'] = icon;
    map['allow_from_to'] = allowFromTo;
    if (validation != null) {
      map['validation'] = validation?.toJson();
    }
    return map;
  }
}

class Validation {
  Validation({
    this.max,
    this.min,
    this.isInt,
    this.required,
    this.validateMax,
    this.validateMin,
  });

  Validation.fromJson(dynamic json) {
    max = json['max'];
    min = json['min'];
    isInt = json['is_int'];
    required = json['required'];
    validateMax = json['validate_max'];
    validateMin = json['validate_min'];
  }
  dynamic max;
  dynamic min;
  dynamic isInt;
  dynamic required;
  dynamic validateMax;
  dynamic validateMin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['max'] = max;
    map['min'] = min;
    map['is_int'] = isInt;
    map['required'] = required;
    map['validate_max'] = validateMax;
    map['validate_min'] = validateMin;
    return map;
  }
}

class Address {
  Address({this.id, this.country, this.city, this.state});

  Address.fromJson(dynamic json) {
    id = json['id'];
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    state = json['state'] != null ? StateData.fromJson(json['state']) : null;
  }
  String? id;
  Country? country;
  City? city;
  StateData? state;

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

class Addations {
  Addations({this.addation, this.price});

  Addations.fromJson(dynamic json) {
    addation =
        json['addation'] != null ? Addation.fromJson(json['addation']) : null;
    price = json['price'];
  }
  Addation? addation;
  String? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (addation != null) {
      map['addation'] = addation?.toJson();
    }
    map['price'] = price;
    return map;
  }
}

class ImageItem {
  ImageItem({this.id, this.url, this.mimeType});

  ImageItem.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
    mimeType = json['mime_type'];
  }
  String? id;
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

class VideoItem {
  VideoItem({this.id, this.url, this.mimeType});

  VideoItem.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
    mimeType = json['mime_type'];
  }
  String? id;
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
