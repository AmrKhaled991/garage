import 'package:garage/core/networking/base/decodable.dart';
import 'package:garage/core/networking/models/vendor.dart';

class Cart extends Decodable<Cart> {
  Cart({
    this.conditions,
    this.subTotal,
    this.total,
    this.count,
    this.items,
    this.vendor,
    this.couponValue,
    this.deliveryTimeNote,
  });

  Cart.fromJson(dynamic json) {
    if (json['conditions'] != null) {
      conditions = [];
      json['conditions'].forEach((v) {
        conditions?.add(Conditions.fromJson(v));
      });
    }
    subTotal = json['subTotal'];
    total = json['total'];
    count = json['count'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(CartItem.fromJson(v));
      });
    }
    vendor = json['vendor'] != null ? Vendor.fromJson(json['vendor']) : null;
    couponValue = json['coupon_value'];
    deliveryTimeNote = json['delivery_time_note'];
  }
  List<Conditions>? conditions;
  String? subTotal;
  String? total;
  num? count;
  List<CartItem>? items;
  Vendor? vendor;
  dynamic couponValue;
  dynamic? deliveryTimeNote;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (conditions != null) {
      map['conditions'] = conditions?.map((v) => v.toJson()).toList();
    }
    map['subTotal'] = subTotal;
    map['total'] = total;
    map['count'] = count;
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    if (vendor != null) {
      map['vendor'] = vendor?.toJson();
    }
    map['coupon_value'] = couponValue;
    map['delivery_time_note'] = deliveryTimeNote;
    return map;
  }

  @override
  Cart decode(data) {
    return Cart.fromJson(data);
  }
}

class Conditions {
  Conditions({
    this.target,
    this.name,
    this.type,
    this.value,
    this.order,
    this.attributes,
  });

  Conditions.fromJson(dynamic json) {
    target = json['target'];
    name = json['name'];
    type = json['type'];
    value = json['value'];
    order = json['order'];
    attributes =
        json['attributes'] != null
            ? Attributes.fromJson(json['attributes'])
            : null;
  }
  String? target;
  String? name;
  String? type;
  String? value;
  int? order;
  Attributes? attributes;
  Conditions copyWith({
    String? target,
    String? name,
    String? type,
    String? value,
    int? order,
    Attributes? attributes,
  }) => Conditions(
    target: target ?? this.target,
    name: name ?? this.name,
    type: type ?? this.type,
    value: value ?? this.value,
    order: order ?? this.order,
    attributes: attributes ?? this.attributes,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['target'] = target;
    map['name'] = name;
    map['type'] = type;
    map['value'] = value;
    map['order'] = order;
    if (attributes != null) {
      map['attributes'] = attributes?.toJson();
    }
    return map;
  }
}

class Attributes {
  Attributes({this.coupon, this.deliveryTimeNote});

  Attributes.fromJson(dynamic json) {
    coupon = json['coupon'] != null ? Coupon.fromJson(json['coupon']) : null;
    deliveryTimeNote = json['delivery_time_note'];
  }
  Coupon? coupon;
  dynamic deliveryTimeNote;
  Attributes copyWith({Coupon? coupon}) =>
      Attributes(coupon: coupon ?? this.coupon);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (coupon != null) {
      map['coupon'] = coupon?.toJson();
    }
    map['delivery_time_note'] = deliveryTimeNote;
    return map;
  }
}

class Coupon {
  Coupon({
    this.id,
    this.code,
    this.title,
    this.discountType,
    this.discountPercentage,
    this.discountValue,
    this.startAt,
    this.expiredAt,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Coupon.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
    discountType = json['discount_type'];
    discountPercentage = json['discount_percentage'];
    discountValue = json['discount_value'];
    startAt = json['start_at'];
    expiredAt = json['expired_at'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? code;
  Title? title;
  dynamic? discountType;
  dynamic? discountPercentage;
  dynamic? discountValue;
  String? startAt;
  String? expiredAt;
  dynamic? status;
  String? createdAt;
  String? updatedAt;
  Coupon copyWith({
    int? id,
    String? code,
    Title? title,
    String? discountType,
    String? discountPercentage,
    String? discountValue,
    String? startAt,
    String? expiredAt,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) => Coupon(
    id: id ?? this.id,
    code: code ?? this.code,
    title: title ?? this.title,
    discountType: discountType ?? this.discountType,
    discountPercentage: discountPercentage ?? this.discountPercentage,
    discountValue: discountValue ?? this.discountValue,
    startAt: startAt ?? this.startAt,
    expiredAt: expiredAt ?? this.expiredAt,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['code'] = code;
    if (title != null) {
      map['title'] = title?.toJson();
    }
    map['discount_type'] = discountType;
    map['discount_percentage'] = discountPercentage;
    map['discount_value'] = discountValue;
    map['start_at'] = startAt;
    map['expired_at'] = expiredAt;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

class Title {
  Title({this.en, this.ar});

  Title.fromJson(dynamic json) {
    en = json['en'];
    ar = json['ar'];
  }
  String? en;
  String? ar;
  Title copyWith({String? en, String? ar}) =>
      Title(en: en ?? this.en, ar: ar ?? this.ar);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['en'] = en;
    map['ar'] = ar;
    return map;
  }
}

class CartItem {
  CartItem({
    this.id,
    this.qty,
    this.image,
    this.productType,
    this.notes,
    this.preparationTimeProduct,
    this.timeAdd,
    this.title,
    this.remainingQty,
    this.price,
    this.productOptions,
  });

  CartItem.fromJson(dynamic json) {
    id = json['id'];
    qty = json['qty'];
    image = json['image'];
    productType = json['product_type'];
    notes = json['notes'];
    preparationTimeProduct = json['preparation_time_product'];
    timeAdd = json['time_add'];
    title = json['title'];
    remainingQty = json['remaining_qty'];
    price = json['price'];
    if (json['product_options'] != null) {
      productOptions = [];
      json['product_options'].forEach((v) {
        productOptions?.add(ProductOptions.fromJson(v));
      });
    }
  }
  String? id;
  num? qty;
  String? image;
  String? productType;
  dynamic notes;
  num? preparationTimeProduct;
  String? timeAdd;
  String? title;
  num? remainingQty;
  String? price;
  List<ProductOptions>? productOptions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['qty'] = qty;
    map['image'] = image;
    map['product_type'] = productType;
    map['notes'] = notes;
    map['preparation_time_product'] = preparationTimeProduct;
    map['time_add'] = timeAdd;
    map['title'] = title;
    map['remaining_qty'] = remainingQty;
    map['price'] = price;
    if (productOptions != null) {
      map['product_options'] = productOptions?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ProductOptions {
  ProductOptions({this.id, this.title, this.optionValue});

  ProductOptions.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    if (json['option_value'] != null) {
      optionValue = [];
      json['option_value'].forEach((v) {
        optionValue?.add(OptionValue.fromJson(v));
      });
    }
  }
  num? id;
  dynamic title;
  List<OptionValue>? optionValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    if (optionValue != null) {
      map['option_value'] = optionValue?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class OptionValue {
  OptionValue({this.id, this.title});

  OptionValue.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
  }
  dynamic? id;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    return map;
  }
}
