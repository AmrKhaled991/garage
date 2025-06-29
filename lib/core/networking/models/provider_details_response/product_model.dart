class ProductModel {
  int? id;
  final String? name;
  final String? description;
  final String? price;
  final Country? madeInCountry;
  final String? image;
  final List<ProductImage>? images;

  ProductModel({
    this.name,
    this.description,
    this.price,
    this.madeInCountry,
    this.image,
    this.images,
    this.id,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      madeInCountry:
          json['made_in_country'] != null
              ? Country.fromJson(json['made_in_country'])
              : null,
      image: json['image'],
      images:
          (json['images'] as List?)
              ?.map((e) => ProductImage.fromJson(e))
              .toList(),
    );
  }
}

class Country {
  final int? id;
  final String? name;
  final String? key;
  final String? flag;

  Country({this.id, this.name, this.key, this.flag});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
      key: json['key'],
      flag: json['flag'],
    );
  }
}

class ProductImage {
  final int? id;
  final String? name;
  final String? fileName;
  final String? mimeType;
  final int? size;
  final String? humanReadableSize;
  final String? url;
  final String? createdAt;

  ProductImage({
    this.id,
    this.name,
    this.fileName,
    this.mimeType,
    this.size,
    this.humanReadableSize,
    this.url,
    this.createdAt,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      name: json['name'],
      fileName: json['file_name'],
      mimeType: json['mime_type'],
      size: json['size'],
      humanReadableSize: json['human_readable_size'],
      url: json['url'],
      createdAt: json['created_at'],
    );
  }
}
