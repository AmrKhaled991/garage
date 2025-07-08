import 'package:garage/core/networking/base/decodable.dart';

import 'item.dart';

class MyOrdersDetails extends Decodable<MyOrdersDetails> {
  int? id;
  String? name;
  String? orderNumber;
  String? orderStatus;
  String? orderStatusColor;
  int? finalTotal;
  String? createdAt;
  String? payStatus;
  String? payStatusColor;
  int? deliveryPrice;
  List<OrderDetailsItem>? items;

  MyOrdersDetails({
    this.id,
    this.name,
    this.orderNumber,
    this.orderStatus,
    this.orderStatusColor,
    this.finalTotal,
    this.createdAt,
    this.payStatus,
    this.payStatusColor,
    this.items,
    this.deliveryPrice,
  });

  factory MyOrdersDetails.fromJson(Map<String, dynamic> json) =>
      MyOrdersDetails(
        id: json['id'] as int?,
        name: json['name'] as String?,
        orderNumber: json['order_number'] as String?,
        orderStatus: json['order_status'] as String?,
        orderStatusColor: json['order_status_color'] as String?,
        finalTotal: json['final_total'] as int?,
        createdAt: json['created_at'] as String?,
        payStatus: json['pay_status'] as String?,
        payStatusColor: json['pay_status_color'] as String?,
        deliveryPrice: json['delivery_price'] as int?,
        items:
            (json['items'] as List<dynamic>?)
                ?.map(
                  (e) => OrderDetailsItem.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
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
    'items': items?.map((e) => e.toJson()).toList(),
  };

  @override
  MyOrdersDetails decode(json) {
    // TODO: implement decode
    return MyOrdersDetails.fromJson(json);
  }
}
