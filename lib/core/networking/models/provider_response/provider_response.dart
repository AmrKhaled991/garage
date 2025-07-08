import 'package:garage/core/networking/base/decodable.dart';

class ProviderResponse extends Decodable<ProviderResponse> {
  int? id;
  String? name;
  String? email;
  String? countryCode;
  String? phone;
  String? fullPhone;
  String? image;
  String? lang;
  bool? isNotify;
  ProviderInfo? data;
  String? token;

  ProviderResponse({
    this.id,
    this.name,
    this.email,
    this.countryCode,
    this.phone,
    this.fullPhone,
    this.image,
    this.lang,
    this.isNotify,
    this.data,
    this.token,
  });

  factory ProviderResponse.fromJson(Map<String, dynamic> json) =>
      ProviderResponse(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        countryCode: json['country_code'] as String?,
        phone: json['phone'] as String?,
        fullPhone: json['full_phone'] as String?,
        image: json['image'] as String?,
        lang: json['lang'] as String?,
        isNotify: json['is_notify'] as bool?,
        data: json['data'] != null ? ProviderInfo.fromJson(json['data']) : null,
        token: json['token'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'country_code': countryCode,
    'phone': phone,
    'full_phone': fullPhone,
    'image': image,
    'lang': lang,
    'is_notify': isNotify,
    'data': data,
    'token': token,
  };

  @override
  ProviderResponse decode(json) {
    // TODO: implement decode
    return ProviderResponse.fromJson(json);
  }
}

class ProviderInfo {
  String? description;
  String? whatsapp;
  String? directPhone;
  String? website;
  String? commercialRegistrationNumber;
  String? x;
  String? tiktok;
  String? snapchat;
  String? instagram;
  String? youtube;
  String? lat;
  String? lng;
  String? mapDesc;
  List<MediaFile>? files;
  List<MediaFile>? video;

  ProviderInfo({
    this.description,
    this.whatsapp,
    this.directPhone,
    this.website,
    this.commercialRegistrationNumber,
    this.x,
    this.tiktok,
    this.snapchat,
    this.instagram,
    this.youtube,
    this.lat,
    this.lng,
    this.mapDesc,
    this.files,
    this.video,
  });

  factory ProviderInfo.fromJson(Map<String, dynamic> json) {
    return ProviderInfo(
      description: json['description'],
      whatsapp: json['whatsapp'],
      directPhone: json['direct_phone'],
      website: json['website'],
      commercialRegistrationNumber: json['commercial_registration_number'],
      x: json['x'],
      tiktok: json['tiktok'],
      snapchat: json['snapchat'],
      instagram: json['instagram'],
      youtube: json['youtube'],
      lat: json['lat'],
      lng: json['lng'],
      mapDesc: json['map_desc'],
      files:
          (json['files'] as List<dynamic>?)
              ?.map((e) => MediaFile.fromJson(e))
              .toList(),
      video:
          (json['video'] as List<dynamic>?)
              ?.map((e) => MediaFile.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'description': description,
    'whatsapp': whatsapp,
    'direct_phone': directPhone,
    'website': website,
    'commercial_registration_number': commercialRegistrationNumber,
    'x': x,
    'tiktok': tiktok,
    'snapchat': snapchat,
    'instagram': instagram,
    'youtube': youtube,
    'lat': lat,
    'lng': lng,
    'map_desc': mapDesc,
    'files': files?.map((e) => e.toJson()).toList(),
    'video': video?.map((e) => e.toJson()).toList(),
  };
}

class MediaFile {
  int? id;
  String? name;
  String? fileName;
  String? mimeType;
  int? size;
  String? humanReadableSize;
  String? url;
  String? createdAt;

  MediaFile({
    this.id,
    this.name,
    this.fileName,
    this.mimeType,
    this.size,
    this.humanReadableSize,
    this.url,
    this.createdAt,
  });

  factory MediaFile.fromJson(Map<String, dynamic> json) {
    return MediaFile(
      id: json['id'],
      name: json['name'],
      fileName: json['file_name'],
      mimeType: json['mime_type'],
      size: json['size'],
      humanReadableSize: json['human_readable_size'],
      url: json['url'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'file_name': fileName,
    'mime_type': mimeType,
    'size': size,
    'human_readable_size': humanReadableSize,
    'url': url,
    'created_at': createdAt,
  };
}
