import 'package:garage/core/networking/base/decodable.dart';

class DeliveryType extends Decodable<DeliveryType> {
  DeliveryType({
    this.type,
    this.title,
    this.message,
    this.times,
    this.withTimes,
  });

  DeliveryType.fromJson(dynamic json) {
    type = json['type'];
    title = json['title'];
    message = json['message'];
    if (json['times'] != null) {
      times = [];
      json['times'].forEach((v) {
        times?.add(Times.fromJson(v));
      });
    }
    withTimes = json['with_times'];
  }
  String? type;
  String? title;
  String? message;
  List<Times>? times;
  bool? withTimes;
  DeliveryType copyWith({
    String? type,
    String? title,
    String? message,
    List<Times>? times,
    bool? withTimes,
  }) => DeliveryType(
    type: type ?? this.type,
    title: title ?? this.title,
    message: message ?? this.message,
    times: times ?? this.times,
    withTimes: withTimes ?? this.withTimes,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['title'] = title;
    map['message'] = message;
    if (times != null) {
      map['times'] = times?.map((v) => v.toJson()).toList();
    }
    map['with_times'] = withTimes;
    return map;
  }

  @override
  DeliveryType decode(data) {
    return DeliveryType.fromJson(data);
  }
}

class Times {
  Times({this.date, this.dayCode, this.dayName, this.times});

  Times.fromJson(dynamic json) {
    date = json['date'];
    dayCode = json['day_code'];
    dayName = json['day_name'];
    if (json['times'] != null) {
      times = [];
      json['times'].forEach((v) {
        times?.add(TimesData.fromJson(v));
      });
    }
  }
  String? date;
  String? dayCode;
  String? dayName;
  List<TimesData>? times;
  Times copyWith({
    String? date,
    String? dayCode,
    String? dayName,
    List<TimesData>? times,
  }) => Times(
    date: date ?? this.date,
    dayCode: dayCode ?? this.dayCode,
    dayName: dayName ?? this.dayName,
    times: times ?? this.times,
  );
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
}

class TimesData {
  TimesData({this.timeFrom, this.timeTo});

  TimesData.fromJson(dynamic json) {
    timeFrom = json['time_from'];
    timeTo = json['time_to'];
  }
  String? timeFrom;
  String? timeTo;
  TimesData copyWith({String? timeFrom, String? timeTo}) => TimesData(
    timeFrom: timeFrom ?? this.timeFrom,
    timeTo: timeTo ?? this.timeTo,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time_from'] = timeFrom;
    map['time_to'] = timeTo;
    return map;
  }
}
