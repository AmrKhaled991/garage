import 'package:get_storage/get_storage.dart';
import 'package:garage/core/networking/models/city.dart';
import 'package:garage/core/networking/models/settings.dart';
import 'package:garage/core/networking/models/user.dart';
import 'package:garage/core/storage/caching_keys.dart';

class PreferenceManager {
  String get getLocale => GetStorage().read(CachingKey.LANGUAGE) ?? "ar";

  void setLocale(String s) {
    GetStorage().write(CachingKey.LANGUAGE, s);
  }

  String get getAccessToken => GetStorage().read(CachingKey.TOKEN) ?? "";

  void setAccessToken(String? s) {
    if (s == null) {
      GetStorage().remove(CachingKey.TOKEN);
    }
    GetStorage().write(CachingKey.TOKEN, s);
  }

  bool get isLangSelected =>
      GetStorage().read(CachingKey.LANGUAGE_SELECTED) ?? false;

  void setLangSelected(bool s) {
    GetStorage().write(CachingKey.LANGUAGE_SELECTED, s);
  }

  User? get getUser {
    if (!GetStorage().hasData(CachingKey.USER)) {
      return null;
    }
    return User.fromJson(GetStorage().read(CachingKey.USER));
  }

  void setUser(User? s) {
    if (s == null) {
      GetStorage().remove(CachingKey.USER);
    }
    GetStorage().write(CachingKey.USER, s?.toJson());
  }

  void saveFCMToken(String fcmToken) =>
      GetStorage().write(CachingKey.FCM_TOKEN, fcmToken);
  String? get getFcmToken => GetStorage().read(CachingKey.FCM_TOKEN);

  Settings? get getSettings {
    if (!GetStorage().hasData(CachingKey.SETTINGS)) {
      return null;
    }
    return Settings.fromJson(GetStorage().read(CachingKey.SETTINGS));
  }

  void setSettings(Settings? s) {
    GetStorage().write(CachingKey.SETTINGS, s?.toJson());
  }

  StateData? get getLastSelectedArea {
    if (!GetStorage().hasData(CachingKey.AREA)) {
      return null;
    }
    return StateData.fromJson(GetStorage().read(CachingKey.AREA));
  }

  void setLastSelectedArea(StateData? s) {
    GetStorage().write(CachingKey.AREA, s?.toJson());
  }

  String? get getAddressName {
    if (!GetStorage().hasData(CachingKey.ADDRESS_NAME)) {
      return null;
    }
    return GetStorage().read(CachingKey.ADDRESS_NAME);
  }

  void setAddressName(String? s) {
    GetStorage().write(CachingKey.ADDRESS_NAME, s);
  }

  String? get getAddressEmail {
    if (!GetStorage().hasData(CachingKey.ADDRESS_EMAIL)) {
      return null;
    }
    return GetStorage().read(CachingKey.ADDRESS_EMAIL);
  }

  void setAddressEmail(String? s) {
    GetStorage().write(CachingKey.ADDRESS_EMAIL, s);
  }

  String? get getAddressPhone {
    if (!GetStorage().hasData(CachingKey.ADDRESS_PHONE)) {
      return null;
    }
    return GetStorage().read(CachingKey.ADDRESS_PHONE);
  }

  void setAddressPhone(String? s) {
    GetStorage().write(CachingKey.ADDRESS_PHONE, s);
  }

  String? get getAddressBlock {
    if (!GetStorage().hasData(CachingKey.ADDRESS_BLOCK)) {
      return null;
    }
    return GetStorage().read(CachingKey.ADDRESS_BLOCK);
  }

  void setAddressBlock(String? s) {
    GetStorage().write(CachingKey.ADDRESS_BLOCK, s);
  }

  String? get getAddressStreet {
    if (!GetStorage().hasData(CachingKey.ADDRESS_STREET)) {
      return null;
    }
    return GetStorage().read(CachingKey.ADDRESS_STREET);
  }

  void setAddressStreet(String? s) {
    GetStorage().write(CachingKey.ADDRESS_STREET, s);
  }

  String? get getAddressBuilding {
    if (!GetStorage().hasData(CachingKey.ADDRESS_BUILDING)) {
      return null;
    }
    return GetStorage().read(CachingKey.ADDRESS_BUILDING);
  }

  void setAddressBuilding(String? s) {
    GetStorage().write(CachingKey.ADDRESS_BUILDING, s);
  }

  String? get getAddressFloor {
    if (!GetStorage().hasData(CachingKey.ADDRESS_FLOOR)) {
      return null;
    }
    return GetStorage().read(CachingKey.ADDRESS_FLOOR);
  }

  void setAddressFloor(String? s) {
    GetStorage().write(CachingKey.ADDRESS_FLOOR, s);
  }

  String? get getAddressFlat {
    if (!GetStorage().hasData(CachingKey.ADDRESS_FLAT)) {
      return null;
    }
    return GetStorage().read(CachingKey.ADDRESS_FLAT);
  }

  void setAddressFlat(String? s) {
    GetStorage().write(CachingKey.ADDRESS_FLAT, s);
  }

  String? get getAddressAvenue {
    if (!GetStorage().hasData(CachingKey.ADDRESS_AVENUE)) {
      return null;
    }
    return GetStorage().read(CachingKey.ADDRESS_AVENUE);
  }

  void setAddressAvenue(String? s) {
    GetStorage().write(CachingKey.ADDRESS_AVENUE, s);
  }

  String? get getAddressOther {
    if (!GetStorage().hasData(CachingKey.ADDRESS_OTHER)) {
      return null;
    }
    return GetStorage().read(CachingKey.ADDRESS_OTHER);
  }

  void setAddressOther(String? s) {
    GetStorage().write(CachingKey.ADDRESS_OTHER, s);
  }

  bool get getIntroShown => GetStorage().read(CachingKey.INTRO_SHOWN) ?? false;

  void setIntroShown() {
    GetStorage().write(CachingKey.INTRO_SHOWN, true);
  }

  void logout() {
    setUser(null);
    setAccessToken(null);
  }
}
