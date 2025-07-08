import 'package:garage/core/networking/base/decodable.dart';

class Reminder extends Decodable<Reminder> {
  int? id;
  String? title;
  String? description;
  String? date;
  String? kilometers;
  String? time;
  String? createdAt;

  Reminder({
    this.id,
    this.title,
    this.description,
    this.date,
    this.kilometers,
    this.time,
    this.createdAt,
  });

  Reminder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    kilometers = json['kilometers'];
    time = json['time'];
    createdAt = json['created_at'];
  }

  @override
  Reminder decode(json) {
    // TODO: implement decode
    return Reminder.fromJson(json);
  }
}
