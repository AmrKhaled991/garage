import 'product.dart';

class CartItem {
  int? id;
  Product? product;
  int? quantity;
  int? totalPrice;

  CartItem({this.id, this.product, this.quantity, this.totalPrice});

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
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
