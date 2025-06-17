import 'package:garage/core/networking/base/decodable.dart';
import 'time.dart';
import 'product_model.dart';

class ProviderDetailsResponse extends Decodable<ProviderDetailsResponse> {
  int? id;
  String? name;
  String? email;
  String? countryCode;
  String? phone;
  String? fullPhone;
  String? image;
  String? lang;
  bool? isNotify;
  ProviderDetailsData? data;
  List<Time>? times;
  List<ProductModel>? products;
  String? token;

  ProviderDetailsResponse({
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
    this.times,
    this.products,
    this.token,
  });

  factory ProviderDetailsResponse.fromJson(Map<String, dynamic> json) =>
      ProviderDetailsResponse(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        countryCode: json['country_code'],
        phone: json['phone'],
        fullPhone: json['full_phone'],
        image: json['image'],
        lang: json['lang'],
        isNotify: json['is_notify'],
        data:
            json['data'] == null
                ? null
                : ProviderDetailsData.fromJson(json['data']),
        times:
            (json['times'] as List<dynamic>?)
                ?.map((e) => Time.fromJson(e as Map<String, dynamic>))
                .toList(),
        products:
            (json['products'] as List<dynamic>?)
                ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
                .toList(),
        token: json['token'],
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
    'data': data?.toJson(),
    'times': times?.map((e) => e.toJson()).toList(),
    'products': products,
    'token': token,
  };

  @override
  ProviderDetailsResponse decode(json) =>
      ProviderDetailsResponse.fromJson(json);
}

// ================== موديل البيانات الداخلية ==================
class ProviderDetailsData {
  CategoryModel? category;
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
  List<FileModel>? files;
  List<VideoModel>? video;

  ProviderDetailsData({
    this.category,
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

  factory ProviderDetailsData.fromJson(Map<String, dynamic> json) =>
      ProviderDetailsData(
        category:
            json['category'] == null
                ? null
                : CategoryModel.fromJson(json['category']),
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
                ?.map((e) => FileModel.fromJson(e))
                .toList(),
        video:
            (json['video'] as List<dynamic>?)
                ?.map((e) => VideoModel.fromJson(e))
                .toList(),
      );

  Map<String, dynamic> toJson() => {
    'category': category?.toJson(),
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

// ================== الموديلات المساعدة ==================

class CategoryModel {
  int? id;
  String? name;
  String? image;
  int? isActive;

  CategoryModel({this.id, this.name, this.image, this.isActive});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json['id'],
    name: json['name'],
    image: json['image'],
    isActive: json['is_active'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'is_active': isActive,
  };
}

class FileModel {
  int? id;
  String? name;
  String? fileName;
  String? mimeType;
  int? size;
  String? humanReadableSize;
  String? url;
  String? createdAt;

  FileModel({
    this.id,
    this.name,
    this.fileName,
    this.mimeType,
    this.size,
    this.humanReadableSize,
    this.url,
    this.createdAt,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
    id: json['id'],
    name: json['name'],
    fileName: json['file_name'],
    mimeType: json['mime_type'],
    size: json['size'],
    humanReadableSize: json['human_readable_size'],
    url: json['url'],
    createdAt: json['created_at'],
  );

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

class VideoModel extends FileModel {
  VideoModel({
    super.id,
    super.name,
    super.fileName,
    super.mimeType,
    super.size,
    super.humanReadableSize,
    super.url,
    super.createdAt,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
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
