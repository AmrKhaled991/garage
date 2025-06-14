import 'package:garage/core/networking/base/decodable.dart';
import 'package:garage/core/networking/models/delivery_type.dart';

import 'category.dart';

class Vendor extends Decodable<Vendor> {
  Vendor({
    this.id,
    this.image,
    this.cover,
    this.title,
    this.description,
    this.rate,
    this.address,
    this.mobile,
    this.preparationTime,
    this.vendorCategories,
    this.openingStatus,
    this.todayDeliveryTimes,
  });

  Vendor.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    cover = json['cover'];
    title = json['title'];
    description = json['description'];
    rate = json['rate'];
    address = json['address'];
    mobile = json['mobile'];
    preparationTime = json['preparation_time'];
    openingStatus =
        json['opening_status'] != null
            ? OpeningStatus.fromJson(json['opening_status'])
            : null;
    todayDeliveryTimes =
        json['today_delivery_times'] != null
            ? Times.fromJson(json['today_delivery_times'])
            : null;
    if (json['vendor_categories'] != null) {
      vendorCategories = [];
      json['vendor_categories'].forEach((v) {
        vendorCategories?.add(Category.fromJson(v));
      });
    }
  }
  int? id;
  String? image;
  String? cover;
  String? title;
  String? description;
  dynamic? rate;
  String? address;
  String? mobile;
  String? preparationTime;
  OpeningStatus? openingStatus;
  Times? todayDeliveryTimes;
  List<Category>? vendorCategories;
  Vendor copyWith({
    int? id,
    String? image,
    String? title,
    String? description,
    int? rate,
    String? address,
    String? mobile,
    OpeningStatus? openingStatus,
    List<Category>? vendorCategories,
  }) => Vendor(
    id: id ?? this.id,
    image: image ?? this.image,
    cover: cover ?? this.cover,
    title: title ?? this.title,
    description: description ?? this.description,
    rate: rate ?? this.rate,
    address: address ?? this.address,
    mobile: mobile ?? this.mobile,
    preparationTime: mobile ?? this.preparationTime,
    openingStatus: openingStatus ?? this.openingStatus,
    todayDeliveryTimes: todayDeliveryTimes ?? this.todayDeliveryTimes,
    vendorCategories: vendorCategories ?? this.vendorCategories,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['cover'] = cover;
    map['title'] = title;
    map['description'] = description;
    map['rate'] = rate;
    map['address'] = address;
    map['mobile'] = mobile;
    map['preparation_time'] = preparationTime;
    if (openingStatus != null) {
      map['opening_status'] = openingStatus?.toJson();
    }
    if (todayDeliveryTimes != null) {
      map['today_delivery_times'] = todayDeliveryTimes?.toJson();
    }
    if (vendorCategories != null) {
      map['vendor_categories'] =
          vendorCategories?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  Vendor decode(data) {
    return Vendor.fromJson(data);
  }
}

class OpeningStatus {
  OpeningStatus({this.status, this.flag, this.acceptingOrders});

  OpeningStatus.fromJson(dynamic json) {
    status = json['status'];
    flag = json['flag'];
    acceptingOrders = json['accepting_orders'];
  }
  String? status;
  String? flag;
  bool? acceptingOrders;
  OpeningStatus copyWith({
    String? status,
    String? flag,
    bool? acceptingOrders,
  }) => OpeningStatus(
    status: status ?? this.status,
    flag: flag ?? this.flag,
    acceptingOrders: acceptingOrders ?? this.acceptingOrders,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['flag'] = flag;
    map['accepting_orders'] = acceptingOrders;
    return map;
  }
}
