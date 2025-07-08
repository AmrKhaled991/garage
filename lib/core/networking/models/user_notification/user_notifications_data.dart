import 'package:garage/core/networking/base/decodable.dart';

import 'notifications.dart';

class UserNotificationsData extends Decodable<UserNotificationsData> {
  Notifications? notifications;

  UserNotificationsData({this.notifications});

  factory UserNotificationsData.fromJson(Map<String, dynamic> json) =>
      UserNotificationsData(
        notifications:
            json['notifications'] == null
                ? null
                : Notifications.fromJson(
                  json['notifications'] as Map<String, dynamic>,
                ),
      );

  Map<String, dynamic> toJson() => {'notifications': notifications?.toJson()};

  @override
  UserNotificationsData decode(json) {
    // TODO: implement decode
    return UserNotificationsData.fromJson(json);
  }
}
