
import 'package:garage/core/networking/base/decodable.dart';

class Settings extends Decodable<Settings>{
  Settings({
    this.appName,
    this.appDescription,
    this.address,
    this.other,
    this.social,
    this.images,
    this.contactUs,
    this.supportedCountries,
    this.aboutApp,
    this.supportedPayments,});

  Settings.fromJson(dynamic json) {
    appName = json['app_name'] != null ? AppName.fromJson(json['app_name']) : null;
    appDescription = json['app_description'] != null ? AppDescription.fromJson(json['app_description']) : null;
    address = json['address'];
    other = json['other'] != null ? Other.fromJson(json['other']) : null;
    social = json['social'] != null ? Social.fromJson(json['social']) : null;
    images = json['images'] != null ? Images.fromJson(json['images']) : null;
    contactUs = json['contact_us'] != null ? ContactUs.fromJson(json['contact_us']) : null;
    supportedCountries = json['supported_countries'] != null ? json['supported_countries'].cast<String>() : [];
    aboutApp = json['about_app'] != null ? AboutApp.fromJson(json['about_app']) : null;
    if (json['supported_payments'] != null) {
      supportedPayments = [];
      json['supported_payments'].forEach((v) {
        supportedPayments?.add(SupportedPayments.fromJson(v));
      });
    }
  }
  AppName? appName;
  AppDescription? appDescription;
  dynamic address;
  Other? other;
  Social? social;
  Images? images;
  ContactUs? contactUs;
  List<String>? supportedCountries;
  AboutApp? aboutApp;
  List<SupportedPayments>? supportedPayments;
  Settings copyWith({  AppName? appName,
    AppDescription? appDescription,
    dynamic address,
    Other? other,
    Social? social,
    Images? images,
    ContactUs? contactUs,
    List<String>? supportedCountries,
    AboutApp? aboutApp,
    List<dynamic>? appGallery,
    List<SupportedPayments>? supportedPayments,
  }) => Settings(  appName: appName ?? this.appName,
    appDescription: appDescription ?? this.appDescription,
    address: address ?? this.address,
    other: other ?? this.other,
    social: social ?? this.social,
    images: images ?? this.images,
    contactUs: contactUs ?? this.contactUs,
    supportedCountries: supportedCountries ?? this.supportedCountries,
    aboutApp: aboutApp ?? this.aboutApp,
    supportedPayments: supportedPayments ?? this.supportedPayments,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (appName != null) {
      map['app_name'] = appName?.toJson();
    }
    if (appDescription != null) {
      map['app_description'] = appDescription?.toJson();
    }
    map['address'] = address;
    if (other != null) {
      map['other'] = other?.toJson();
    }
    if (social != null) {
      map['social'] = social?.toJson();
    }
    if (images != null) {
      map['images'] = images?.toJson();
    }
    if (contactUs != null) {
      map['contact_us'] = contactUs?.toJson();
    }
    map['supported_countries'] = supportedCountries;
    if (aboutApp != null) {
      map['about_app'] = aboutApp?.toJson();
    }
    if (supportedPayments != null) {
      map['supported_payments'] = supportedPayments?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  Settings decode(data) {
    return Settings.fromJson(data);
  }

}

class SupportedPayments {
  SupportedPayments({
    this.key,
    this.title,});

  SupportedPayments.fromJson(dynamic json) {
    key = json['key'];
    title = json['title'];
  }
  String? key;
  String? title;
  SupportedPayments copyWith({  String? key,
    String? title,
  }) => SupportedPayments(  key: key ?? this.key,
    title: title ?? this.title,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = key;
    map['title'] = title;
    return map;
  }

}

class AboutApp {
  AboutApp({
    this.androidDownloadUrl,
    this.iosDownloadUrl,});

  AboutApp.fromJson(dynamic json) {
    androidDownloadUrl = json['android_download_url'];
    iosDownloadUrl = json['ios_download_url'];
  }
  dynamic androidDownloadUrl;
  dynamic iosDownloadUrl;
  AboutApp copyWith({  dynamic androidDownloadUrl,
    dynamic iosDownloadUrl,
  }) => AboutApp(  androidDownloadUrl: androidDownloadUrl ?? this.androidDownloadUrl,
    iosDownloadUrl: iosDownloadUrl ?? this.iosDownloadUrl,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['android_download_url'] = androidDownloadUrl;
    map['ios_download_url'] = iosDownloadUrl;
    return map;
  }

}

class ContactUs {
  ContactUs({
    this.email,
    this.whatsapp,
    this.mobile,
    this.technicalSupport,});

  ContactUs.fromJson(dynamic json) {
    email = json['email'];
    whatsapp = json['whatsapp'];
    mobile = json['mobile'];
    technicalSupport = json['technical_support'];
  }
  String? email;
  String? whatsapp;
  dynamic mobile;
  dynamic technicalSupport;
  ContactUs copyWith({  String? email,
    String? whatsapp,
    dynamic mobile,
    dynamic technicalSupport,
  }) => ContactUs(  email: email ?? this.email,
    whatsapp: whatsapp ?? this.whatsapp,
    mobile: mobile ?? this.mobile,
    technicalSupport: technicalSupport ?? this.technicalSupport,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['whatsapp'] = whatsapp;
    map['mobile'] = mobile;
    map['technical_support'] = technicalSupport;
    return map;
  }

}

class Images {
  Images({
    this.logo,
    this.whiteLogo,
    this.favicon,});

  Images.fromJson(dynamic json) {
    logo = json['logo'];
    whiteLogo = json['white_logo'];
    favicon = json['favicon'];
  }
  String? logo;
  String? whiteLogo;
  String? favicon;
  Images copyWith({  String? logo,
    String? whiteLogo,
    String? favicon,
  }) => Images(  logo: logo ?? this.logo,
    whiteLogo: whiteLogo ?? this.whiteLogo,
    favicon: favicon ?? this.favicon,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['logo'] = logo;
    map['white_logo'] = whiteLogo;
    map['favicon'] = favicon;
    return map;
  }

}

class Social {
  Social({
    this.facebook,
    this.twitter,
    this.instagram,
    this.linkedin,
    this.youtube,
    this.snapchat,});

  Social.fromJson(dynamic json) {
    facebook = json['facebook'];
    twitter = json['twitter'];
    instagram = json['instagram'];
    linkedin = json['linkedin'];
    youtube = json['youtube'];
    snapchat = json['snapchat'];
  }
  String? facebook;
  String? twitter;
  String? instagram;
  String? linkedin;
  String? youtube;
  String? snapchat;
  Social copyWith({  String? facebook,
    String? twitter,
    String? instagram,
    String? linkedin,
    String? youtube,
    String? snapchat,
  }) => Social(  facebook: facebook ?? this.facebook,
    twitter: twitter ?? this.twitter,
    instagram: instagram ?? this.instagram,
    linkedin: linkedin ?? this.linkedin,
    youtube: youtube ?? this.youtube,
    snapchat: snapchat ?? this.snapchat,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['facebook'] = facebook;
    map['twitter'] = twitter;
    map['instagram'] = instagram;
    map['linkedin'] = linkedin;
    map['youtube'] = youtube;
    map['snapchat'] = snapchat;
    return map;
  }

}

class Other {
  Other({
    this.privacyPolicy,
    this.terms,
    this.aboutUs,
    this.depositPayment,
    this.forceUpdate,});

  Other.fromJson(dynamic json) {
    privacyPolicy = json['privacy_policy'];
    terms = json['terms'];
    aboutUs = json['about_us'];
    depositPayment = json['deposit_payment'] != null ? DepositPayment.fromJson(json['deposit_payment']) : null;
    forceUpdate = json['force_update'];
  }
  String? privacyPolicy;
  String? terms;
  String? aboutUs;
  DepositPayment? depositPayment;
  String? forceUpdate;
  Other copyWith({  String? privacyPolicy,
    String? terms,
    String? aboutUs,
    DepositPayment? depositPayment,
    String? forceUpdate,
  }) => Other(  privacyPolicy: privacyPolicy ?? this.privacyPolicy,
    terms: terms ?? this.terms,
    aboutUs: aboutUs ?? this.aboutUs,
    depositPayment: depositPayment ?? this.depositPayment,
    forceUpdate: forceUpdate ?? this.forceUpdate,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['privacy_policy'] = privacyPolicy;
    map['terms'] = terms;
    map['about_us'] = aboutUs;
    if (depositPayment != null) {
      map['deposit_payment'] = depositPayment?.toJson();
    }
    map['force_update'] = forceUpdate;
    return map;
  }

}

class DepositPayment {
  DepositPayment({
    this.status,
    this.percentage,});

  DepositPayment.fromJson(dynamic json) {
    status = json['status'];
    percentage = json['percentage'];
  }
  String? status;
  String? percentage;
  DepositPayment copyWith({  String? status,
    String? percentage,
  }) => DepositPayment(  status: status ?? this.status,
    percentage: percentage ?? this.percentage,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['percentage'] = percentage;
    return map;
  }

}

class AppDescription {
  AppDescription({
    this.en,
    this.ar,});

  AppDescription.fromJson(dynamic json) {
    en = json['en'];
    ar = json['ar'];
  }
  String? en;
  String? ar;
  AppDescription copyWith({  String? en,
    String? ar,
  }) => AppDescription(  en: en ?? this.en,
    ar: ar ?? this.ar,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['en'] = en;
    map['ar'] = ar;
    return map;
  }

}

class AppName {
  AppName({
    this.en,
    this.ar,});

  AppName.fromJson(dynamic json) {
    en = json['en'];
    ar = json['ar'];
  }
  String? en;
  String? ar;
  AppName copyWith({  String? en,
    String? ar,
  }) => AppName(  en: en ?? this.en,
    ar: ar ?? this.ar,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['en'] = en;
    map['ar'] = ar;
    return map;
  }

}