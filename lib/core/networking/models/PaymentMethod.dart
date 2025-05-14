import 'package:garage/core/networking/base/decodable.dart';

class PaymentMethod extends Decodable<PaymentMethod>{
  PaymentMethod({
      this.code, 
      this.title, 
      this.value,});

  PaymentMethod.fromJson(dynamic json) {
    code = json['code'];
    title = json['title'];
    value = json['value'];
    icon = json['icon'];
  }
  String? code;
  String? title;
  String? icon;
  num? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['title'] = title;
    map['value'] = value;
    map['icon'] = icon;
    return map;
  }

  @override
  PaymentMethod decode(json) {
    return PaymentMethod.fromJson(json);
  }

}