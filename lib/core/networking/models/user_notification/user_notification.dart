import 'package:garage/core/networking/models/user_notification/notifications_details.dart';

class UserNotification {
  String? id;
  String? type;
  String? title;
  String? body;
  NotificationsDetails? data;
  String? createdAt;

  UserNotification({
    this.id,
    this.type,
    this.title,
    this.body,
    this.data,
    this.createdAt,
  });

  factory UserNotification.fromJson(Map<String, dynamic> json) =>
      UserNotification(
        id: json['id'] as String?,
        type: json['type'] as String?,
        title: json['title'] as String?,
        body: json['body'] as String?,
        data:
            json['data'] == null
                ? null
                : NotificationsDetails.fromJson(
                  json['data'] as Map<String, dynamic>,
                ),
        createdAt: json['created_at'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'title': title,
    'body': body,
    // 'data': data?.toJson(),
    'created_at': createdAt,
  };
}
