
import 'package:garage/core/networking/base/decodable.dart';

import 'product.dart';

class CategoriesWithProducts extends Decodable<CategoriesWithProducts>{
  CategoriesWithProducts({
    this.id,
    this.title,
    this.products,});

  CategoriesWithProducts.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Product.fromJson(v));
      });
    }
  }
  int? id;
  String? title;
  List<Product>? products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  CategoriesWithProducts decode(data) {
    return CategoriesWithProducts.fromJson(data);
  }

}