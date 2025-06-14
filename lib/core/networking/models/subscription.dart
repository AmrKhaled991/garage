import 'package:garage/core/networking/base/decodable.dart';
import 'package:garage/core/networking/models/package.dart';

class SubscriptionData extends Decodable<SubscriptionData> {
  SubscriptionData({
    this.id,
    this.isFree,
    this.isDefault,
    this.durationOfAds,
    this.allowUse,
    this.startAt,
    this.endAt,
    this.currentUse,
    this.maxUse,
    this.renewalAt,
    this.renewalCount,
    this.package,
    this.createdAt,
  });

  SubscriptionData.fromJson(dynamic json) {
    id = json['id'];
    isFree = json['is_free'];
    isDefault = json['is_default'];
    durationOfAds = json['duration_of_ads'];
    allowUse = json['allow_use'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    currentUse = json['current_use'];
    maxUse = json['max_use'];
    renewalAt = json['renewal_at'];
    renewalCount = json['renewal_count'];
    package =
        json['package'] != null ? PackageData.fromJson(json['package']) : null;
    createdAt = json['created_at'];
  }
  String? id;
  int? isFree;
  int? isDefault;
  String? durationOfAds;
  bool? allowUse;
  String? startAt;
  String? endAt;
  int? currentUse;
  int? maxUse;
  String? renewalAt;
  int? renewalCount;
  PackageData? package;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['is_free'] = isFree;
    map['is_default'] = isDefault;
    map['duration_of_ads'] = durationOfAds;
    map['allow_use'] = allowUse;
    map['start_at'] = startAt;
    map['end_at'] = endAt;
    map['current_use'] = currentUse;
    map['max_use'] = maxUse;
    map['renewal_at'] = renewalAt;
    map['renewal_count'] = renewalCount;
    if (package != null) {
      map['package'] = package?.toJson();
    }
    map['created_at'] = createdAt;
    return map;
  }

  @override
  SubscriptionData decode(data) {
    return SubscriptionData.fromJson(data);
  }
}
