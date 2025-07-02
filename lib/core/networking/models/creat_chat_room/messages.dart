import 'datum.dart';
import 'pagination.dart';

class Messages {
  Pagination? pagination;
  List<MessagesInfo>? data;

  Messages({this.pagination, this.data});

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
    pagination:
        json['pagination'] == null
            ? null
            : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    data:
        (json['data'] as List<dynamic>?)
            ?.map((e) => MessagesInfo.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'pagination': pagination?.toJson(),
    'data': data?.map((e) => e.toJson()).toList(),
  };
}
