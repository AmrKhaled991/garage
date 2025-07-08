import 'package:garage/core/networking/base/decodable.dart';

class CouponData extends Decodable<CouponData> {
  CouponData({this.discountAmount, this.finalPrice, this.coupon});

  CouponData.fromJson(dynamic json) {
    discountAmount = json['discount_amount'];
    finalPrice = json['final_price'];
    coupon = json['coupon'] != null ? Coupon.fromJson(json['coupon']) : null;
  }
  String? discountAmount;
  String? finalPrice;
  Coupon? coupon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['discount_amount'] = discountAmount;
    map['final_price'] = finalPrice;
    if (coupon != null) {
      map['coupon'] = coupon?.toJson();
    }
    return map;
  }

  @override
  CouponData decode(data) {
    return CouponData.fromJson(data);
  }
}

class Coupon {
  Coupon({this.type, this.discount, this.id});

  Coupon.fromJson(dynamic json) {
    type = json['type'];
    discount = json['discount'];
    id = json['id'];
  }
  String? type;
  num? discount;
  num? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['discount'] = discount;
    map['id'] = id;
    return map;
  }
}
