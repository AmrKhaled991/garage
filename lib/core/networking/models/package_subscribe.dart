import 'package:garage/core/networking/base/decodable.dart';

class PackageSubscribe extends Decodable<PackageSubscribe> {
  PackageSubscribe({this.subscription, this.url});

  PackageSubscribe.fromJson(dynamic json) {
    subscription =
        json['subscription'] != null
            ? Subscription.fromJson(json['subscription'])
            : null;
    url = json['url'];
  }
  Subscription? subscription;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (subscription != null) {
      map['subscription'] = subscription?.toJson();
    }
    map['url'] = url;
    return map;
  }

  @override
  PackageSubscribe decode(data) {
    return PackageSubscribe.fromJson(data);
  }
}

class Subscription {
  Subscription({
    this.id,
    // this.isFree,
    // this.isDefault,
    this.durationOfAds,
    this.allowUse,
    this.startAt,
    this.endAt,
    this.currentUse,
    this.maxUse,
    this.renewalAt,
    this.renewalCount,
    this.createdAt,
  });

  Subscription.fromJson(dynamic json) {
    id = json['id'];
    // isFree = json['is_free'];
    // isDefault = json['is_default'];
    durationOfAds = json['duration_of_ads'];
    allowUse = json['allow_use'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    currentUse = json['current_use'];
    maxUse = json['max_use'];
    renewalAt = json['renewal_at'];
    renewalCount = json['renewal_count'];
    createdAt = json['created_at'];
  }
  String? id;
  // bool? isFree;
  // dynamic isDefault;
  dynamic durationOfAds;
  bool? allowUse;
  String? startAt;
  String? endAt;
  dynamic currentUse;
  dynamic maxUse;
  String? renewalAt;
  dynamic renewalCount;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    // map['is_free'] = isFree;
    // map['is_default'] = isDefault;
    map['duration_of_ads'] = durationOfAds;
    map['allow_use'] = allowUse;
    map['start_at'] = startAt;
    map['end_at'] = endAt;
    map['current_use'] = currentUse;
    map['max_use'] = maxUse;
    map['renewal_at'] = renewalAt;
    map['renewal_count'] = renewalCount;
    map['created_at'] = createdAt;
    return map;
  }
}
