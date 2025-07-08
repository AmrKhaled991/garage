import 'package:garage/core/networking/base/decodable.dart';

class Payment extends Decodable<Payment> {
  Payment({this.url});

  Payment.fromJson(dynamic json) {
    url = json['payment_url'];
  }
  String? url;

  static var obs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['payment_url'] = url;
    return map;
  }

  @override
  Payment decode(data) {
    return Payment.fromJson(data);
  }
}
