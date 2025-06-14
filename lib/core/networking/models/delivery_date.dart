import 'package:garage/core/networking/base/decodable.dart';

class DeliveryDate extends Decodable<DeliveryDate> {
  DeliveryDate({this.fullDate, this.date, this.intervals});

  DeliveryDate.fromJson(dynamic json) {
    fullDate = json['full_date'];
    date = json['date'];
    if (json['intervals'] != null) {
      intervals = [];
      json['intervals'].forEach((v) {
        intervals?.add(IntervalData.fromJson(v));
      });
    }
  }
  String? fullDate;
  String? date;
  List<IntervalData>? intervals;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['full_date'] = fullDate;
    map['date'] = date;
    if (intervals != null) {
      map['intervals'] = intervals?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  DeliveryDate decode(json) {
    return DeliveryDate.fromJson(json);
  }
}

class IntervalData {
  IntervalData({this.intervalId, this.from, this.to});

  IntervalData.fromJson(dynamic json) {
    intervalId = json['interval_id'];
    from = json['from'];
    to = json['to'];
  }
  num? intervalId;
  String? from;
  String? to;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['interval_id'] = intervalId;
    map['from'] = from;
    map['to'] = to;
    return map;
  }
}
