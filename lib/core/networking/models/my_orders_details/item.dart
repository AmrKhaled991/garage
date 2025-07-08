import 'product.dart';

class OrderDetailsItem {
  int? id;
  Product? product;
  int? quantity;
  int? totalPrice;

  OrderDetailsItem({this.id, this.product, this.quantity, this.totalPrice});

  factory OrderDetailsItem.fromJson(Map<String, dynamic> json) =>
      OrderDetailsItem(
        id: json['id'] as int?,
        product:
            json['product'] == null
                ? null
                : Product.fromJson(json['product'] as Map<String, dynamic>),
        quantity: json['quantity'] as int?,
        totalPrice: json['total_price'] as int?,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'product': product?.toJson(),
    'quantity': quantity,
    'total_price': totalPrice,
  };
}
