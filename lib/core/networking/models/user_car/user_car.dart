import 'package:garage/core/networking/base/decodable.dart';

import 'brand.dart';

class UserCar extends Decodable<UserCar> {
  int? id;
  Brand? brand;
  String? model;
  String? year;
  String? carOwnerName;

  UserCar({this.id, this.brand, this.model, this.year, this.carOwnerName});

  factory UserCar.fromJson(Map<String, dynamic> json) => UserCar(
    id: json['id'] as int?,
    brand:
        json['brand'] == null
            ? null
            : Brand.fromJson(json['brand'] as Map<String, dynamic>),
    model: json['model'] as String?,
    year: json['year'] as String?,
    carOwnerName: json['car_owner_name'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'brand': brand?.toJson(),
    'model': model,
    'year': year,
    'car_owner_name': carOwnerName,
  };

  @override
  UserCar decode(json) {
    // TODO: implement decode
    return UserCar.fromJson(json);
  }
}
