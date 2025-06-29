import 'image.dart';
import 'made_in_country.dart';

class Product {
  int? id;
  String? name;
  String? description;
  String? price;
  MadeInCountry? madeInCountry;
  String? image;
  List<Image>? images;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.madeInCountry,
    this.image,
    this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'] as int?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    price: json['price'] as String?,
    madeInCountry:
        json['made_in_country'] == null
            ? null
            : MadeInCountry.fromJson(
              json['made_in_country'] as Map<String, dynamic>,
            ),
    image: json['image'] as String?,
    images:
        (json['images'] as List<dynamic>?)
            ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'price': price,
    'made_in_country': madeInCountry?.toJson(),
    'image': image,
    'images': images?.map((e) => e.toJson()).toList(),
  };
}
