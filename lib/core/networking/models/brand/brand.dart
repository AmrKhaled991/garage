import 'package:garage/core/networking/base/decodable.dart';

class Brand extends Decodable<Brand> {
  int? id;
  String? name;
  String? image;

  Brand({this.id, this.name, this.image});

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json['id'] as int?,
    name: json['name'] as String?,
    image: json['image'] as String?,
  );

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'image': image};

  @override
  Brand decode(json) {
    return Brand.fromJson(json);
  }
}
