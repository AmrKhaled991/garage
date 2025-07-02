import 'package:garage/core/networking/models/user_notification/body.dart';
import 'package:garage/core/networking/models/user_notification/title.dart';

class NotificationsDetails {
  Body? body;
  Title? title;

  NotificationsDetails({this.body, this.title});

  NotificationsDetails.fromJson(Map<String, dynamic> json) {
    body = json['body'] != null ? Body.fromJson(json['body']) : null;
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
  }
}
