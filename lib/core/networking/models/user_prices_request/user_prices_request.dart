import 'package:garage/core/networking/base/decodable.dart';

import 'category.dart';
import 'file.dart';
import 'provider.dart';

class UserPricesRequest extends Decodable<UserPricesRequest> {
  int? id;
  Provider? provider;
  List<File>? files;
  int? quantity;
  String? details;
  String? orderNumber;
  String? status;
  Category? category;
  DateTime? createdAt;

  UserPricesRequest({
    this.id,
    this.provider,
    this.files,
    this.quantity,
    this.category,
    this.createdAt,
    this.details,
    this.orderNumber,
    this.status,
  });

  factory UserPricesRequest.fromJson(Map<String, dynamic> json) =>
      UserPricesRequest(
        id: json['id'] as int?,
        details: json['details'] as String?,
        orderNumber: json['order_number'] as String?,
        status: json['status'] as String?,
        provider:
            json['provider'] == null
                ? null
                : Provider.fromJson(json['provider'] as Map<String, dynamic>),
        files:
            (json['files'] as List<dynamic>?)
                ?.map((e) => File.fromJson(e as Map<String, dynamic>))
                .toList(),
        quantity: json['quantity'] as int?,
        category:
            json['category'] == null
                ? null
                : Category.fromJson(json['category'] as Map<String, dynamic>),
        createdAt:
            json['created_at'] == null
                ? null
                : DateTime.parse(json['created_at'] as String),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'provider': provider?.toJson(),
    'files': files?.map((e) => e.toJson()).toList(),
    'quantity': quantity,
    'category': category?.toJson(),
    'created_at': createdAt?.toIso8601String(),
  };

  @override
  UserPricesRequest decode(json) {
    return UserPricesRequest.fromJson(json);
  }
}
