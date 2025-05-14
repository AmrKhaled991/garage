

import 'package:garage/core/networking/base/decodable.dart';

class City extends Decodable<City>{
  City({
    this.id,
    this.title,
    this.states,});

  City.fromJson(dynamic json) {
    id = json['id'];
    title = json['name'];
    if (json['cities'] != null) {
      states = [];
      json['cities'].forEach((v) {
        states?.add(StateData.fromJson(v));
      });
    }
  }
  int? id;
  String? title;
  List<StateData>? states;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = title;
    if (states != null) {
      map['cities'] = states?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  City decode(data) {
    return City.fromJson(data);
  }

}

class StateData {
  StateData({
    this.id,
    this.title,
    this.countryId,});

  StateData.fromJson(dynamic json) {
    id = json['id'];
    title = json['name'];
    country = json['region'];
    countryId = json['country_id'];
  }
  int? id;
  String? title;
  String? country;
  int? countryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = title;
    map['region'] = country;
    map['country_id'] = countryId;
    return map;
  }

}