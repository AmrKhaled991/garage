import 'package:garage/core/networking/base/decodable.dart';

import 'record.dart';

class HomeResponse extends Decodable<HomeResponse> {
  int? id;
  String? title;
  String? description;
  String? type;
  List<Record>? records;
  String? displayType;
  dynamic gridColumnsCount;

  HomeResponse({
    this.id,
    this.title,
    this.description,
    this.type,
    this.records,
    this.displayType,
    this.gridColumnsCount,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
    id: json['id'] as int?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    type: json['type'] as String?,
    records:
        (json['records'] as List<dynamic>?)
            ?.map((e) => Record.fromJson(e as Map<String, dynamic>))
            .toList(),
    displayType: json['display_type'] as String?,
    gridColumnsCount: json['grid_columns_count'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'type': type,
    'records': records?.map((e) => e.toJson()).toList(),
    'display_type': displayType,
    'grid_columns_count': gridColumnsCount,
  };

  @override
  HomeResponse decode(json) {
    return HomeResponse.fromJson(json);
  }
}
