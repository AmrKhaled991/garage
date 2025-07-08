import 'package:garage/core/networking/base/decodable.dart';

class AddAddition extends Decodable {
  AddAddition({this.order, this.url});

  AddAddition.fromJson(dynamic json) {
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    url = json['url'];
  }
  Order? order;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (order != null) {
      map['order'] = order?.toJson();
    }
    map['url'] = url;
    return map;
  }

  @override
  decode(data) {
    return AddAddition.fromJson(data);
  }
}

class Order {
  Order({this.id, this.total, this.isPaid});

  Order.fromJson(dynamic json) {
    id = json['id'];
    total = json['total'];
    isPaid = json['is_paid'];
  }
  String? id;
  dynamic total;
  bool? isPaid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['total'] = total;
    map['is_paid'] = isPaid;
    return map;
  }
}
