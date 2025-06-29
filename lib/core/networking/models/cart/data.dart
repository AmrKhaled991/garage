import 'package:garage/core/networking/base/decodable.dart';

import 'item.dart';

class Cart extends Decodable<Cart> {
  int? itemsCount;
  int? totalProductsPrice;
  int? totalProductsPriceWithDelivery;
  int? deliveryPrice;
  List<CartItem>? items;

  Cart({
    this.itemsCount,
    this.totalProductsPrice,
    this.totalProductsPriceWithDelivery,
    this.deliveryPrice,
    this.items,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    itemsCount: json['items_count'] as int?,
    totalProductsPrice: json['total_products_price'] as int?,
    totalProductsPriceWithDelivery:
        json['total_products_price_with_delivery'] as int?,
    deliveryPrice: json['delivery_price'] as int?,
    items:
        (json['items'] as List<dynamic>?)
            ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'items_count': itemsCount,
    'total_products_price': totalProductsPrice,
    'total_products_price_with_delivery': totalProductsPriceWithDelivery,
    'delivery_price': deliveryPrice,
    'items': items?.map((e) => e.toJson()).toList(),
  };

  @override
  Cart decode(json) {
    // TODO: implement decode
    return Cart.fromJson(json);
  }
}
