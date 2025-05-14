
import 'package:garage/core/networking/base/decodable.dart';

class Attribute extends Decodable<Attribute>{
  Attribute({
    this.id,
    this.type,
    this.name,
    this.icon,
    this.allowFromTo,
    this.options,
    this.validation,});

  Attribute.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    icon = json['icon'];
    allowFromTo = json['allow_from_to'];
    if (json['options'] != null) {
      options = [];
      json['options'].forEach((v) {
        options?.add(Options.fromJson(v));
      });
    }
    validation = json['validation'] != null ? Validation.fromJson(json['validation']) : null;
  }
  int? id;
  String? type;
  String? name;
  String? icon;
  int? allowFromTo;
  List<Options>? options;
  Validation? validation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['name'] = name;
    map['icon'] = icon;
    map['allow_from_to'] = allowFromTo;
    if (options != null) {
      map['options'] = options?.map((v) => v.toJson()).toList();
    }
    if (validation != null) {
      map['validation'] = validation?.toJson();
    }
    return map;
  }

  @override
  Attribute decode(data) {
    return Attribute.fromJson(data);
  }

}

class Validation {
  Validation({
    this.required,
    this.isInt,
    this.validateMax,
    this.validateMin,
    this.min,
    this.max,});

  Validation.fromJson(dynamic json) {
    required = json['required'];
    isInt = json['is_int'];
    validateMax = json['validate_max'];
    validateMin = json['validate_min'];
    min = json['min'];
    max = json['max'];
  }
  dynamic required;
  dynamic isInt;
  dynamic validateMax;
  dynamic validateMin;
  dynamic min;
  dynamic max;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['required'] = required;
    map['is_int'] = isInt;
    map['validate_max'] = validateMax;
    map['validate_min'] = validateMin;
    map['min'] = min;
    map['max'] = max;
    return map;
  }

}

class Options {
  Options({
    this.id,
    this.value,
    this.isDefault,});

  Options.fromJson(dynamic json) {
    id = json['id'];
    value = json['value'];
    isDefault = json['is_default'];
  }
  int? id;
  dynamic value;
  dynamic isDefault;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['value'] = value;
    map['is_default'] = isDefault;
    return map;
  }

}