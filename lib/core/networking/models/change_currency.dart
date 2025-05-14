import 'package:garage/core/networking/base/decodable.dart';

class ChangeCurrency extends Decodable<ChangeCurrency>{
  ChangeCurrency({
      this.equalAmount,});

  ChangeCurrency.fromJson(dynamic json) {
    equalAmount = json['equal_amount'];
  }
  dynamic equalAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['equal_amount'] = equalAmount;
    return map;
  }

  @override
  ChangeCurrency decode(json) {
    return ChangeCurrency.fromJson(json);
  }

}