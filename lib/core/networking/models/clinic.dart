import 'package:garage/core/networking/base/decodable.dart';
import 'package:garage/core/networking/models/category.dart';
import 'package:garage/core/networking/models/doctor.dart';

class Clinic extends Decodable<Clinic> {
  Clinic({
    this.id,
    this.categoryName,
    this.categoryId,
    this.images,
    this.coverImage,
    this.name,
    this.subcategories,
    this.desc,
    this.address,
    this.lat,
    this.lng,
    this.supportServices,
    this.rate,
    this.rateCount,
    this.files,
    this.doctors,
  });

  Clinic.fromJson(dynamic json) {
    id = json['id'];
    categoryName = json['category_name'];
    categoryId = json['category_id'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
    coverImage = json['cover_image'];
    logoImage = json['logo_image'];
    name = json['name'];
    if (json['subcategories'] != null) {
      subcategories = [];
      json['subcategories'].forEach((v) {
        subcategories?.add(Category.fromJson(v));
      });
    }
    desc = json['desc'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    supportServices = json['support_services'];
    rate = json['rate'];
    rateCount = json['rate_count'];
    if (json['files'] != null) {
      files = [];
      // json['files'].forEach((v) {
      //   files?.add(Dynamic.fromJson(v));
      // });
    }
    if (json['doctors'] != null) {
      doctors = [];
      json['doctors'].forEach((v) {
        doctors?.add(Doctor.fromJson(v));
      });
    }
    times = json['times'] != null ? Times.fromJson(json['times']) : null;
  }
  num? id;
  String? categoryName;
  num? categoryId;
  List<Images>? images;
  String? coverImage;
  String? logoImage;
  String? name;
  List<Category>? subcategories;
  String? desc;
  String? address;
  String? lat;
  String? lng;
  bool? supportServices;
  num? rate;
  num? rateCount;
  List<dynamic>? files;
  List<Doctor>? doctors;
  Times? times;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['category_name'] = categoryName;
    map['category_id'] = categoryId;
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    map['cover_image'] = coverImage;
    map['logo_image'] = logoImage;
    map['name'] = name;
    if (subcategories != null) {
      map['subcategories'] = subcategories?.map((v) => v.toJson()).toList();
    }
    map['desc'] = desc;
    map['address'] = address;
    map['lat'] = lat;
    map['lng'] = lng;
    map['support_services'] = supportServices;
    map['rate'] = rate;
    map['rate_count'] = rateCount;
    if (files != null) {
      map['files'] = files?.map((v) => v.toJson()).toList();
    }
    if (doctors != null) {
      map['doctors'] = doctors?.map((v) => v.toJson()).toList();
    }
    if (times != null) {
      map['times'] = times?.toJson();
    }
    return map;
  }

  @override
  Clinic decode(json) {
    return Clinic.fromJson(json);
  }
}

class Times {
  Times({this.saturday, this.sunday, this.monday, this.tuesday});

  Times.fromJson(dynamic json) {
    if (json['saturday'] != null) {
      saturday = [];
      json['saturday'].forEach((v) {
        saturday?.add(WeekDay.fromJson(v));
      });
    }
    if (json['sunday'] != null) {
      sunday = [];
      json['sunday'].forEach((v) {
        sunday?.add(WeekDay.fromJson(v));
      });
    }
    if (json['monday'] != null) {
      monday = [];
      json['monday'].forEach((v) {
        monday?.add(WeekDay.fromJson(v));
      });
    }
    if (json['tuesday'] != null) {
      tuesday = [];
      json['tuesday'].forEach((v) {
        tuesday?.add(WeekDay.fromJson(v));
      });
    }
    if (json['wednesday'] != null) {
      wednesday = [];
      json['wednesday'].forEach((v) {
        wednesday?.add(WeekDay.fromJson(v));
      });
    }
    if (json['thursday'] != null) {
      thursday = [];
      json['thursday'].forEach((v) {
        thursday?.add(WeekDay.fromJson(v));
      });
    }
    if (json['friday'] != null) {
      friday = [];
      json['friday'].forEach((v) {
        friday?.add(WeekDay.fromJson(v));
      });
    }
  }
  List<WeekDay>? saturday;
  List<WeekDay>? sunday;
  List<WeekDay>? monday;
  List<WeekDay>? tuesday;
  List<WeekDay>? wednesday;
  List<WeekDay>? thursday;
  List<WeekDay>? friday;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (saturday != null) {
      map['saturday'] = saturday?.map((v) => v.toJson()).toList();
    }
    if (sunday != null) {
      map['sunday'] = sunday?.map((v) => v.toJson()).toList();
    }
    if (monday != null) {
      map['monday'] = monday?.map((v) => v.toJson()).toList();
    }
    if (tuesday != null) {
      map['tuesday'] = tuesday?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class WeekDay {
  WeekDay({this.from, this.to});

  WeekDay.fromJson(dynamic json) {
    from = json['from'];
    to = json['to'];
  }
  String? from;
  String? to;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['from'] = from;
    map['to'] = to;
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
