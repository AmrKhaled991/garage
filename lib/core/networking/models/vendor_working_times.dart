import 'package:garage/core/networking/base/decodable.dart';

class VendorWorkingTimes extends Decodable<VendorWorkingTimes> {
  VendorWorkingTimes({this.date, this.dayCode, this.dayName, this.times});

  VendorWorkingTimes.fromJson(dynamic json) {
    date = json['date'];
    dayCode = json['day_code'];
    dayName = json['day_name'];
    if (json['times'] != null) {
      times = [];
      json['times'].forEach((v) {
        times?.add(Times.fromJson(v));
      });
    }
  }
  String? date;
  String? dayCode;
  String? dayName;
  List<Times>? times;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['day_code'] = dayCode;
    map['day_name'] = dayName;
    if (times != null) {
      map['times'] = times?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  VendorWorkingTimes decode(data) {
    return VendorWorkingTimes.fromJson(data);
  }
}

class Times {
  Times({this.timeFrom, this.timeTo});

  Times.fromJson(dynamic json) {
    timeFrom = json['time_from'];
    timeTo = json['time_to'];
  }
  String? timeFrom;
  String? timeTo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time_from'] = timeFrom;
    map['time_to'] = timeTo;
    return map;
  }
}
