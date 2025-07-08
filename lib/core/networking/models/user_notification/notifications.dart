import 'package:garage/core/networking/base/decodable.dart';

import 'user_notification.dart';
import 'pagination.dart';

class Notifications extends Decodable<Notifications> {
  Pagination? pagination;
  List<UserNotification>? data;

  Notifications({this.pagination, this.data});

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
    pagination:
        json['pagination'] == null
            ? null
            : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    data:
        (json['data'] as List<dynamic>?)
            ?.map((e) => UserNotification.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'pagination': pagination?.toJson(),
    'data': data?.map((e) => e.toJson()).toList(),
  };

  @override
  Notifications decode(json) {
    // TODO: implement decode
    return Notifications.fromJson(json);
  }
}
