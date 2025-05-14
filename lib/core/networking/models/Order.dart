
import 'package:garage/core/networking/base/decodable.dart';

class OrderData extends Decodable<OrderData>{
  OrderData({
    this.id,
    this.total,
    this.shipping,
    this.subtotal,
    this.transaction,
    this.orderStatus,
    this.isRated,
    this.rate,
    this.createdAt,
    this.notes,
    this.products,
    this.address,
    this.vendors,});

  OrderData.fromJson(dynamic json) {
    id = json['id'];
    total = json['total'];
    shipping = json['shipping'];
    subtotal = json['subtotal'];
    transaction = json['transaction'];
    orderStatus = json['order_status'] != null ? OrderStatus.fromJson(json['order_status']) : null;
    isRated = json['is_rated'];
    rate = json['rate'];
    createdAt = json['created_at'];
    notes = json['notes'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(OrderProduct.fromJson(v));
      });
    }
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['vendors'] != null) {
      vendors = [];
      json['vendors'].forEach((v) {
        vendors?.add(Vendors.fromJson(v));
      });
    }
  }
  num? id;
  String? total;
  String? shipping;
  String? subtotal;
  String? transaction;
  OrderStatus? orderStatus;
  bool? isRated;
  num? rate;
  String? createdAt;
  dynamic notes;
  List<OrderProduct>? products;
  Address? address;
  List<Vendors>? vendors;
  OrderData copyWith({  num? id,
    String? total,
    String? shipping,
    String? subtotal,
    String? transaction,
    OrderStatus? orderStatus,
    bool? isRated,
    num? rate,
    String? createdAt,
    dynamic notes,
    List<OrderProduct>? products,
    Address? address,
    List<Vendors>? vendors,
  }) => OrderData(  id: id ?? this.id,
    total: total ?? this.total,
    shipping: shipping ?? this.shipping,
    subtotal: subtotal ?? this.subtotal,
    transaction: transaction ?? this.transaction,
    orderStatus: orderStatus ?? this.orderStatus,
    isRated: isRated ?? this.isRated,
    rate: rate ?? this.rate,
    createdAt: createdAt ?? this.createdAt,
    notes: notes ?? this.notes,
    products: products ?? this.products,
    address: address ?? this.address,
    vendors: vendors ?? this.vendors,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['total'] = total;
    map['shipping'] = shipping;
    map['subtotal'] = subtotal;
    map['transaction'] = transaction;
    if (orderStatus != null) {
      map['order_status'] = orderStatus?.toJson();
    }
    map['is_rated'] = isRated;
    map['rate'] = rate;
    map['created_at'] = createdAt;
    map['notes'] = notes;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    if (address != null) {
      map['address'] = address?.toJson();
    }
    if (vendors != null) {
      map['vendors'] = vendors?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  OrderData decode(data) {
    return OrderData.fromJson(data);
  }

}

class Vendors {
  Vendors({
    this.id,
    this.image,
    this.title,
    this.mobile,
    this.rate,});

  Vendors.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    mobile = json['mobile'];
    rate = json['rate'];
  }
  num? id;
  String? image;
  String? title;
  dynamic mobile;
  dynamic? rate;
  Vendors copyWith({  num? id,
    String? image,
    String? title,
    dynamic mobile,
    dynamic? rate,
  }) => Vendors(  id: id ?? this.id,
    image: image ?? this.image,
    title: title ?? this.title,
    mobile: mobile ?? this.mobile,
    rate: rate ?? this.rate,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['title'] = title;
    map['mobile'] = mobile;
    map['rate'] = rate;
    return map;
  }

}

class Address {
  Address({
    this.id,
    this.email,
    this.mobile,
    this.username,
    this.stateId,
    this.state,
    this.block,
    this.building,
    this.street,
    this.avenue,
    this.floor,
    this.flat,
    this.automatedNumber,
    this.additions,
    this.city,
    this.country,});

  Address.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    mobile = json['mobile'];
    username = json['username'];
    stateId = json['state_id'];
    state = json['state'];
    block = json['block'];
    building = json['building'];
    street = json['street'];
    avenue = json['avenue'];
    floor = json['floor'];
    flat = json['flat'];
    automatedNumber = json['automated_number'];
    additions = json['additions'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    country = json['country'] != null ? Country.fromJson(json['country']) : null;
  }
  num? id;
  String? email;
  String? mobile;
  String? username;
  dynamic stateId;
  String? state;
  String? block;
  String? building;
  String? street;
  String? avenue;
  String? floor;
  String? flat;
  dynamic automatedNumber;
  dynamic additions;
  City? city;
  Country? country;
  Address copyWith({  num? id,
    String? email,
    String? mobile,
    String? username,
    String? stateId,
    String? state,
    String? block,
    String? building,
    String? street,
    String? avenue,
    String? floor,
    String? flat,
    dynamic automatedNumber,
    dynamic additions,
    City? city,
    Country? country,
  }) => Address(  id: id ?? this.id,
    email: email ?? this.email,
    mobile: mobile ?? this.mobile,
    username: username ?? this.username,
    stateId: stateId ?? this.stateId,
    state: state ?? this.state,
    block: block ?? this.block,
    building: building ?? this.building,
    street: street ?? this.street,
    avenue: avenue ?? this.avenue,
    floor: floor ?? this.floor,
    flat: flat ?? this.flat,
    automatedNumber: automatedNumber ?? this.automatedNumber,
    additions: additions ?? this.additions,
    city: city ?? this.city,
    country: country ?? this.country,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['mobile'] = mobile;
    map['username'] = username;
    map['state_id'] = stateId;
    map['state'] = state;
    map['block'] = block;
    map['building'] = building;
    map['street'] = street;
    map['avenue'] = avenue;
    map['floor'] = floor;
    map['flat'] = flat;
    map['automated_number'] = automatedNumber;
    map['additions'] = additions;
    if (city != null) {
      map['city'] = city?.toJson();
    }
    if (country != null) {
      map['country'] = country?.toJson();
    }
    return map;
  }

}

class Country {
  Country({
    this.id,
    this.title,});

  Country.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
  }
  num? id;
  String? title;
  Country copyWith({  num? id,
    String? title,
  }) => Country(  id: id ?? this.id,
    title: title ?? this.title,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    return map;
  }

}

class City {
  City({
    this.id,
    this.title,});

  City.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
  }
  num? id;
  String? title;
  City copyWith({  num? id,
    String? title,
  }) => City(  id: id ?? this.id,
    title: title ?? this.title,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    return map;
  }

}

class OrderProduct {
  OrderProduct({
    this.sellingPrice,
    this.qty,
    this.total,
    this.notes,
    this.title,
    this.image,
    this.sku,
    // this.addons,
  });

  OrderProduct.fromJson(dynamic json) {
    sellingPrice = json['selling_price'];
    qty = json['qty'];
    total = json['total'];
    notes = json['notes'];
    title = json['title'];
    image = json['image'];
    sku = json['sku'];
    // if (json['addons'] != null) {
    //   addons = [];
    //   json['addons'].forEach((v) {
    //     addons?.add(Dynamic.fromJson(v));
    //   });
    // }
  }
  String? sellingPrice;
  dynamic qty;
  String? total;
  dynamic notes;
  String? title;
  String? image;
  String? sku;
  List<dynamic>? addons;
  OrderProduct copyWith({  String? sellingPrice,
    String? qty,
    String? total,
    dynamic notes,
    String? title,
    String? image,
    String? sku,
    // List<dynamic>? addons,
  }) => OrderProduct(  sellingPrice: sellingPrice ?? this.sellingPrice,
    qty: qty ?? this.qty,
    total: total ?? this.total,
    notes: notes ?? this.notes,
    title: title ?? this.title,
    image: image ?? this.image,
    sku: sku ?? this.sku,
    // addons: addons ?? this.addons,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['selling_price'] = sellingPrice;
    map['qty'] = qty;
    map['total'] = total;
    map['notes'] = notes;
    map['title'] = title;
    map['image'] = image;
    map['sku'] = sku;
    // if (addons != null) {
    //   map['addons'] = addons?.map((v) => v.toJson()).toList();
    // }
    return map;
  }

}

class OrderStatus {
  OrderStatus({
    this.flag,
    this.title,});

  OrderStatus.fromJson(dynamic json) {
    flag = json['flag'];
    title = json['title'];
  }
  String? flag;
  String? title;
  OrderStatus copyWith({  String? flag,
    String? title,
  }) => OrderStatus(  flag: flag ?? this.flag,
    title: title ?? this.title,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['flag'] = flag;
    map['title'] = title;
    return map;
  }

}