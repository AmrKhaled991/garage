
import 'package:garage/core/networking/base/decodable.dart';
import 'package:garage/core/networking/models/user.dart';

class CurrentRate  extends Decodable{
  CurrentRate({
    this.user,
    this.currentUserRate,});

  CurrentRate.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    currentUserRate = json['current_user_rate'] != null ? CurrentUserRate.fromJson(json['current_user_rate']) : null;
  }
  User? user;
  CurrentUserRate? currentUserRate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (currentUserRate != null) {
      map['current_user_rate'] = currentUserRate?.toJson();
    }
    return map;
  }

  @override
  decode(data) {
    return CurrentRate.fromJson(data);
  }

}

class CurrentUserRate {
  CurrentUserRate({
    this.id,
    this.rate,
    this.note,
    this.createdAt,
    this.updatedAt,});

  CurrentUserRate.fromJson(dynamic json) {
    id = json['id'];
    rate = json['rate'];
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  String? id;
  int? rate;
  dynamic note;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['rate'] = rate;
    map['note'] = note;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}
