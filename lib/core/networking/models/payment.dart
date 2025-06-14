import 'package:garage/core/networking/base/decodable.dart';

class Payment extends Decodable<Payment> {
  Payment({this.url});

  Payment.fromJson(dynamic json) {
    url = json['PaymentUrl'];
  }
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PaymentUrl'] = url;
    return map;
  }

  @override
  Payment decode(data) {
    return Payment.fromJson(data);
  }
}
