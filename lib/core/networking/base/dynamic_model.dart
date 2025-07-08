import 'decodable.dart';

class DynamicModel extends Decodable<DynamicModel> {
  DynamicModel({this.data});

  dynamic data;

  @override
  DynamicModel decode(json) {
    this.data = json['data'];
    return this;
  }
}
