

import 'package:garage/core/networking/base/decodable.dart';
import 'package:garage/core/networking/models/vendor.dart';

class Product extends Decodable<Product>{
  Product({
    this.id,
    this.sku,
    this.price,
    this.originPrice,
    this.qty,
    this.image,
    this.title,
    this.description,
    this.shortDescription,
    this.vendor,
    this.offer,
    this.images,
    this.tags,
    this.productsOptions,
    this.addons,
    this.sharableLink,
    this.preparationTime,
    this.isFavorite,});

  Product.fromJson(dynamic json) {
    id = json['id'];
    sku = json['sku'];
    price = json['price'];
    originPrice = json['origin_price'];
    qty = json['qty'];
    image = json['image'];
    title = json['title'];
    description = json['description'];
    shortDescription = json['short_description'];
    offer = json['offer'] != null ? ProductOffer.fromJson(json['offer']) : null;
    vendor = json['vendor'] != null ? Vendor.fromJson(json['vendor']) : null;
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((v) {
        tags?.add(Tags.fromJson(v));
      });
    }
    if (json['products_options'] != null) {
      productsOptions = [];
      json['products_options'].forEach((v) {
        productsOptions?.add(ProductsOptions.fromJson(v));
      });
    }
    if (json['addons'] != null) {
      addons = [];
      json['addons'].forEach((v) {
        addons?.add(Addons.fromJson(v));
      });
    }
    sharableLink = json['sharable_link'];
    preparationTime = json['preparation_time'];
    isFavorite = json['is_favorite'];
  }
  int? id;
  String? sku;
  String? price;
  String? originPrice;
  dynamic qty;
  String? image;
  String? title;
  String? description;
  String? shortDescription;
  Vendor? vendor;
  ProductOffer? offer;
  List<Images>? images;
  List<Tags>? tags;
  List<ProductsOptions>? productsOptions;
  List<Addons>? addons;
  String? sharableLink;
  String? preparationTime;
  dynamic isFavorite;
  Product copyWith({  int? id,
    String? sku,
    String? price,
    String? originPrice,
    dynamic qty,
    String? image,
    String? title,
    String? description,
    String? shortDescription,
    Vendor? vendor,
    ProductOffer? offer,
    List<Images>? images,
    List<Tags>? tags,
    List<ProductsOptions>? productsOptions,
    List<Addons>? addons,
    String? sharableLink,
    dynamic isFavorite,
  }) => Product(  id: id ?? this.id,
    sku: sku ?? this.sku,
    price: price ?? this.price,
    originPrice: originPrice ?? this.originPrice,
    qty: qty ?? this.qty,
    image: image ?? this.image,
    title: title ?? this.title,
    description: description ?? this.description,
    shortDescription: shortDescription ?? this.shortDescription,
    vendor: vendor ?? this.vendor,
    offer: offer ?? this.offer,
    images: images ?? this.images,
    tags: tags ?? this.tags,
    productsOptions: productsOptions ?? this.productsOptions,
    addons: addons ?? this.addons,
    sharableLink: sharableLink ?? this.sharableLink,
    preparationTime: preparationTime ?? this.preparationTime,
    isFavorite: isFavorite ?? this.isFavorite,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['sku'] = sku;
    map['price'] = price;
    map['origin_price'] = originPrice;
    map['qty'] = qty;
    map['image'] = image;
    map['title'] = title;
    map['description'] = description;
    map['short_description'] = shortDescription;
    if (vendor != null) {
      map['vendor'] = vendor?.toJson();
    }
    if (offer != null) {
      map['offer'] = offer?.toJson();
    }
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    if (tags != null) {
      map['tags'] = tags?.map((v) => v.toJson()).toList();
    }
    if (productsOptions != null) {
      map['products_options'] = productsOptions?.map((v) => v.toJson()).toList();
    }
    if (addons != null) {
      map['addons'] = addons?.map((v) => v.toJson()).toList();
    }
    map['sharable_link'] = sharableLink;
    map['preparation_time'] = preparationTime;
    map['is_favorite'] = isFavorite;
    return map;
  }

  @override
  Product decode(data) {
    return Product.fromJson(data);
  }

}

class Addons {
  Addons({
    this.id,
    this.name,
    this.image,
    this.type,
    this.minOptionsCount,
    this.maxOptionsCount,
    this.isRequired,
    this.createdAt,
    this.addonOptions,});

  Addons.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    type = json['type'];
    minOptionsCount = json['min_options_count'];
    maxOptionsCount = json['max_options_count'];
    isRequired = json['is_required'];
    createdAt = json['created_at'];
    if (json['addonOptions'] != null) {
      addonOptions = [];
      json['addonOptions'].forEach((v) {
        addonOptions?.add(AddonOptions.fromJson(v));
      });
    }
  }
  int? id;
  String? name;
  String? image;
  String? type;
  dynamic minOptionsCount;
  dynamic maxOptionsCount;
  bool? isRequired;
  String? createdAt;
  List<AddonOptions>? addonOptions;
  Addons copyWith({  int? id,
    String? name,
    String? image,
    String? type,
    dynamic minOptionsCount,
    dynamic maxOptionsCount,
    bool? isRequired,
    String? createdAt,
    List<AddonOptions>? addonOptions,
  }) => Addons(  id: id ?? this.id,
    name: name ?? this.name,
    image: image ?? this.image,
    type: type ?? this.type,
    minOptionsCount: minOptionsCount ?? this.minOptionsCount,
    maxOptionsCount: maxOptionsCount ?? this.maxOptionsCount,
    isRequired: isRequired ?? this.isRequired,
    createdAt: createdAt ?? this.createdAt,
    addonOptions: addonOptions ?? this.addonOptions,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['type'] = type;
    map['min_options_count'] = minOptionsCount;
    map['max_options_count'] = maxOptionsCount;
    map['is_required'] = isRequired;
    map['created_at'] = createdAt;
    if (addonOptions != null) {
      map['addonOptions'] = addonOptions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class AddonOptions {
  AddonOptions({
    this.id,
    this.option,
    this.price,
    this.qty,
    this.image,
    this.default_,});

  AddonOptions.fromJson(dynamic json) {
    id = json['id'];
    option = json['option'];
    price = json['price'];
    qty = json['qty'];
    image = json['image'];
    default_ = json['default'];
  }
  int? id;
  String? option;
  String? price;
  dynamic qty;
  String? image;
  int? default_;
  AddonOptions copyWith({  int? id,
    String? option,
    String? price,
    dynamic qty,
    String? image,
    int? default_,
  }) => AddonOptions(  id: id ?? this.id,
    option: option ?? this.option,
    price: price ?? this.price,
    qty: qty ?? this.qty,
    image: image ?? this.image,
    default_: default_ ?? this.default_,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['option'] = option;
    map['price'] = price;
    map['qty'] = qty;
    map['image'] = image;
    map['default'] = default_;
    return map;
  }

}

class ProductsOptions {
  ProductsOptions({
    this.type,});

  ProductsOptions.fromJson(dynamic json) {
    type = json['type'];
  }
  String? type;
  ProductsOptions copyWith({  String? type,
  }) => ProductsOptions(  type: type ?? this.type,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    return map;
  }

}

class Tags {
  Tags({
    this.id,
    this.title,
    this.color,
    this.background,
    this.image,});

  Tags.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    color = json['color'];
    background = json['background'];
    image = json['image'];
  }
  int? id;
  String? title;
  String? color;
  String? background;
  dynamic image;
  Tags copyWith({  int? id,
    String? title,
    String? color,
    String? background,
    dynamic image,
  }) => Tags(  id: id ?? this.id,
    title: title ?? this.title,
    color: color ?? this.color,
    background: background ?? this.background,
    image: image ?? this.image,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['color'] = color;
    map['background'] = background;
    map['image'] = image;
    return map;
  }

}

class Images {
  Images({
    this.url,});

  Images.fromJson(dynamic json) {
    url = json['url'];
  }
  String? url;
  Images copyWith({  String? url,
  }) => Images(  url: url ?? this.url,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    return map;
  }

}

class ProductOffer {
  ProductOffer({
    this.offerPrice,});

  ProductOffer.fromJson(dynamic json) {
    offerPrice = json['offer_price'];
  }
  String? offerPrice;
  ProductOffer copyWith({  String? offerPrice,
  }) => ProductOffer(  offerPrice: offerPrice ?? this.offerPrice,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['offer_price'] = offerPrice;
    return map;
  }

}