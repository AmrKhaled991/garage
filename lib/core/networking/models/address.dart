import 'package:garage/core/networking/base/decodable.dart';

import 'city.dart';

class AddressData extends Decodable<AddressData> {
  AddressData({
    this.id,
    this.email,
    this.username,
    this.mobile,
    this.block,
    this.street,
    this.building,
    this.state,
    this.stateId,
    this.avenue,
    this.floor,
    this.flat,
    this.automatedNumber,
    this.additions,
    this.isDefault,
    this.city,
    this.country,
  });

  AddressData.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    mobile = json['mobile'];
    block = json['block'];
    street = json['street'];
    building = json['building'];
    state = json['state'];
    stateId = json['state_id'];
    avenue = json['avenue'];
    floor = json['floor'];
    flat = json['flat'];
    automatedNumber = json['automated_number'];
    additions = json['additions'];
    isDefault = json['is_default'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
  }
  int? id;
  String? email;
  String? username;
  String? mobile;
  String? block;
  String? street;
  String? building;
  String? state;
  int? stateId;
  String? avenue;
  String? floor;
  String? flat;
  String? automatedNumber;
  String? additions;
  bool? isDefault;
  City? city;
  Country? country;
  AddressData copyWith({
    int? id,
    String? email,
    String? username,
    String? mobile,
    String? block,
    String? street,
    String? building,
    String? state,
    int? stateId,
    String? avenue,
    String? floor,
    String? flat,
    String? automatedNumber,
    String? additions,
    bool? isDefault,
    City? city,
    Country? country,
  }) => AddressData(
    id: id ?? this.id,
    email: email ?? this.email,
    username: username ?? this.username,
    mobile: mobile ?? this.mobile,
    block: block ?? this.block,
    street: street ?? this.street,
    building: building ?? this.building,
    state: state ?? this.state,
    stateId: stateId ?? this.stateId,
    avenue: avenue ?? this.avenue,
    floor: floor ?? this.floor,
    flat: flat ?? this.flat,
    automatedNumber: automatedNumber ?? this.automatedNumber,
    additions: additions ?? this.additions,
    isDefault: isDefault ?? this.isDefault,
    city: city ?? this.city,
    country: country ?? this.country,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['username'] = username;
    map['mobile'] = mobile;
    map['block'] = block;
    map['street'] = street;
    map['building'] = building;
    map['state'] = state;
    map['state_id'] = stateId;
    map['avenue'] = avenue;
    map['floor'] = floor;
    map['flat'] = flat;
    map['automated_number'] = automatedNumber;
    map['additions'] = additions;
    map['is_default'] = isDefault;
    if (city != null) {
      map['city'] = city?.toJson();
    }
    if (country != null) {
      map['country'] = country?.toJson();
    }
    return map;
  }

  @override
  AddressData decode(data) {
    return AddressData.fromJson(data);
  }
}

class Country {
  Country({this.id, this.title});

  Country.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
  }
  int? id;
  String? title;
  Country copyWith({int? id, String? title}) =>
      Country(id: id ?? this.id, title: title ?? this.title);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    return map;
  }
}
