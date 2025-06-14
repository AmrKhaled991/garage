import 'package:garage/core/networking/base/decodable.dart';
import 'package:garage/core/networking/models/category.dart';

class Restaurant extends Decodable<Restaurant> {
  Restaurant({
    this.id,
    this.categoryName,
    this.categoryId,
    this.images,
    this.image,
    this.coverImage,
    this.name,
    this.subcategories,
    this.desc,
    this.address,
    this.lat,
    this.lng,
    this.rate,
    this.rateCount,
    this.socials,
    this.branches,
  });

  Restaurant.fromJson(dynamic json) {
    id = json['id'];
    categoryName = json['category_name'];
    categoryId = json['category_id'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
    image = json['image'];
    coverImage = json['cover_image'];
    name = json['name'];
    if (json['subcategories'] != null) {
      subcategories = [];
      json['subcategories'].forEach((v) {
        subcategories?.add(Category.fromJson(v));
      });
    }
    desc = json['desc'];
    notes = json['notes'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    rate = json['rate'];
    rateCount = json['rate_count'];
    isFavorite = json['is_fav'];
    if (json['socials'] != null) {
      socials = [];
      json['socials'].forEach((v) {
        socials?.add(Socials.fromJson(v));
      });
    }
    if (json['branches'] != null) {
      branches = [];
      json['branches'].forEach((v) {
        branches?.add(Branch.fromJson(v));
      });
    }
  }
  num? id;
  String? categoryName;
  num? categoryId;
  List<Images>? images;
  String? image;
  String? coverImage;
  String? name;
  List<Category>? subcategories;
  String? desc;
  String? notes;
  String? address;
  String? lat;
  String? lng;
  num? rate;
  num? rateCount;
  bool? isFavorite;
  List<Socials>? socials;
  List<Branch>? branches;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['category_name'] = categoryName;
    map['category_id'] = categoryId;
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    map['image'] = image;
    map['cover_image'] = coverImage;
    map['name'] = name;
    if (subcategories != null) {
      map['subcategories'] = subcategories?.map((v) => v.toJson()).toList();
    }
    map['desc'] = desc;
    map['notes'] = notes;
    map['address'] = address;
    map['lat'] = lat;
    map['lng'] = lng;
    map['rate'] = rate;
    map['rate_count'] = rateCount;
    map['is_fav'] = isFavorite;
    if (socials != null) {
      map['socials'] = socials?.map((v) => v.toJson()).toList();
    }
    if (branches != null) {
      map['branches'] = branches?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  Restaurant decode(json) {
    return Restaurant.fromJson(json);
  }
}

class Branch {
  Branch({
    this.id,
    this.image,
    this.name,
    this.notes,
    this.showPrice,
    this.services,
    this.rate,
  });

  Branch.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    notes = json['notes'];
    showPrice = json['show_price'];
    if (json['services'] != null) {
      services = [];
      json['services'].forEach((v) {
        services?.add(Services.fromJson(v));
      });
    }
    if (json['hours'] != null) {
      hours = [];
      json['hours'].forEach((v) {
        hours?.add(Hours.fromJson(v));
      });
    }
    rate = json['rate'];
  }
  num? id;
  String? image;
  String? name;
  String? notes;
  bool? showPrice;
  List<Services>? services;
  List<Hours>? hours;
  num? rate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['name'] = name;
    map['notes'] = notes;
    map['show_price'] = showPrice;
    if (services != null) {
      map['services'] = services?.map((v) => v.toJson()).toList();
    }
    if (hours != null) {
      map['hours'] = hours?.map((v) => v.toJson()).toList();
    }
    map['rate'] = rate;
    return map;
  }
}

class Hours {
  Hours({this.day, this.startTime, this.endTime});

  Hours.fromJson(dynamic json) {
    day = json['day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }
  String? day;
  String? startTime;
  String? endTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = day;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
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

class Socials {
  Socials({this.name, this.icon, this.link});

  Socials.fromJson(dynamic json) {
    name = json['name'];
    icon = json['icon'];
    link = json['link'];
  }
  String? name;
  String? icon;
  String? link;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['icon'] = icon;
    map['link'] = link;
    return map;
  }
}

class Images {
  Images({this.id, this.path, this.extension, this.description});

  Images.fromJson(dynamic json) {
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
