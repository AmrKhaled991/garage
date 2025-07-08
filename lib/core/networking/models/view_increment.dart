import 'package:garage/core/networking/base/decodable.dart';

class ViewIncrement extends Decodable<ViewIncrement> {
  ViewIncrement({this.view});

  ViewIncrement.fromJson(dynamic json) {
    view = json['view'];
  }
  int? view;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['view'] = view;
    return map;
  }

  @override
  ViewIncrement decode(data) {
    return ViewIncrement.fromJson(data);
  }
}
