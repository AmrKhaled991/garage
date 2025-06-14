import 'dart:convert';

NotificationData notificationDataFromJson(String str) =>
    NotificationData.fromJson(json.decode(str));

String notificationDataToJson(NotificationData data) =>
    json.encode(data.toJson());

class NotificationData {
  NotificationData({this.id, this.type});

  String? id;
  String? type;

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "type": type == null ? null : type,
  };
}
