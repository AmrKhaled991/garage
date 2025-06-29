import 'package:garage/core/networking/base/decodable.dart';

class MyOrder extends Decodable<MyOrder> {
  int? id;
  String? name;
  String? orderNumber;
  String? orderStatus;
  String? orderStatusColor;
  int? finalTotal;
  String? createdAt;
  String? payStatus;
  String? payStatusColor;

  MyOrder({
    this.id,
    this.name,
    this.orderNumber,
    this.orderStatus,
    this.orderStatusColor,
    this.finalTotal,
    this.createdAt,
    this.payStatus,
    this.payStatusColor,
  });

  factory MyOrder.fromJson(Map<String, dynamic> json) => MyOrder(
    id: json['id'] as int?,
    name: json['name'] as String?,
    orderNumber: json['order_number'] as String?,
    orderStatus: json['order_status'] as String?,
    orderStatusColor: json['order_status_color'] as String?,
    finalTotal: json['final_total'] as int?,
    createdAt: json['created_at'] as String?,
    payStatus: json['pay_status'] as String?,
    payStatusColor: json['pay_status_color'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'order_number': orderNumber,
    'order_status': orderStatus,
    'order_status_color': orderStatusColor,
    'final_total': finalTotal,
    'created_at': createdAt,
    'pay_status': payStatus,
    'pay_status_color': payStatusColor,
  };

  @override
  MyOrder decode(json) {
    return MyOrder.fromJson(json);
  }
}
