import 'package:garage/core/networking/base/decodable.dart';

class Times extends Decodable<Times> {
  Times({this.isAvailable, this.times});

  Times.fromJson(dynamic json) {
    isAvailable = json['is_available'];
    if (json['times'] != null) {
      times = [];
      json['times'].forEach((v) {
        times?.add(Time.fromJson(v));
      });
    }
  }
  bool? isAvailable;
  List<Time>? times;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_available'] = isAvailable;
    if (times != null) {
      map['times'] = times?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  Times decode(json) {
    return Times.fromJson(json);
  }
}

class Time {
  Time({this.time});

  Time.fromJson(dynamic json) {
    isAvailable = json['is_available'];
    time = json['time'];
    timeEn = json['time_en'];
  }
  String? time;
  String? timeEn;
  bool? isAvailable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = time;
    map['time_en'] = timeEn;
    map['is_available'] = isAvailable;
    return map;
  }
}
