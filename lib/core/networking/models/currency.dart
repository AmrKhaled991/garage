import 'package:garage/core/networking/base/decodable.dart';

class Currency extends Decodable<Currency> {
  Currency({
    this.id,
    this.countryName,
    this.countryFlag,
    this.code,
    this.isDefault,
    this.sellingPrice,
    this.buyingPrice,
  });

  Currency.fromJson(dynamic json) {
    id = json['id'];
    countryName = json['country_name'];
    countryFlag = json['country_flag'];
    code = json['code'];
    isDefault = json['is_default'];
    sellingPrice = json['selling_price'];
    buyingPrice = json['buying_price'];
  }
  int? id;
  String? countryName;
  String? countryFlag;
  String? code;
  bool? isDefault;
  String? sellingPrice;
  String? buyingPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['country_name'] = countryName;
    map['country_flag'] = countryFlag;
    map['code'] = code;
    map['is_default'] = isDefault;
    map['selling_price'] = sellingPrice;
    map['buying_price'] = buyingPrice;
    return map;
  }

  @override
  Currency decode(json) {
    return Currency.fromJson(json);
  }
}
