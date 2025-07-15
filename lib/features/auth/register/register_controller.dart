import 'dart:math';

import 'package:garage/core/helpers/time_formater.dart';
import 'package:garage/core/ui/select_drop_list%20.dart';
import 'package:garage/features/auth/company_profile_edit/models/time_slot.dart';
import 'package:garage/features/main/common/models/map_result.dart';
import 'package:get/get.dart';
import 'package:garage/utils/utlis.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'register_state.dart';

class RegisterController extends GetxController {
  final RegisterState state = RegisterState();
  String? now = DateTimeFormatter.formatHour12(DateTime.now());

  @override
  void onInit() {
    super.onInit();
    state.listTimeSlot.value = [
      TimeSlot(day: 'saturday'.tr, start: now, end: now, isSelected: false),
      TimeSlot(day: 'sunday'.tr, start: now, end: now, isSelected: false),
      TimeSlot(day: 'monday'.tr, start: now, end: now, isSelected: false),
      TimeSlot(day: 'tuesday'.tr, start: now, end: now, isSelected: false),
      TimeSlot(day: 'wednesday'.tr, start: now, end: now, isSelected: false),
      TimeSlot(day: 'thursday'.tr, start: now, end: now, isSelected: false),
    ];
  }

  bool validations() {
    if (state.phoneNumber.text.isBlank == true) {
      Utils.showSnackBar("error_phone".tr);
      return false;
    } else if (state.password.text.isBlank == true) {
      Utils.showSnackBar("error_password".tr);
      return false;
    } else if (state.passwordConfirm.text.isBlank == true) {
      Utils.showSnackBar("error_password_confirm".tr);
      return false;
    } else if (state.password.text != state.passwordConfirm.text) {
      Utils.showSnackBar("error_not_match".tr);
      return false;
    }
    return true;
  }

  addAndRemoveTimeSlot(TimeSlot timeSlot) {
    var index = state.listTimeSlot.value.indexWhere(
      (e) => e.day == timeSlot.day,
    );
    state.listTimeSlot[index].isSelected =
        (state.listTimeSlot[index].isSelected);
    state.listTimeSlot.refresh();
  }

  addStartTime(TimeSlot timeSlot) {
    var index = state.listTimeSlot.indexWhere((e) => e.day == timeSlot.day);
    state.listTimeSlot[index].start = timeSlot.start;
    state.listTimeSlot.refresh();
  }

  addEndTime(TimeSlot timeSlot) {
    var index = state.listTimeSlot.indexWhere((e) => e.day == timeSlot.day);
    state.listTimeSlot[index].end = timeSlot.end;
    state.listTimeSlot.refresh();
  }

  Map<String, dynamic> getMapToJson() {
    Map<String, String> weekDaysMap = {
      'saturday': 'السبت',
      'sunday': 'الاحد',
      'monday': 'الاثنين',
      'tuesday': 'الثلاثاء',
      'wednesday': 'الاربعاء',
      'thursday': 'الخميس',
      'friday': 'الجمعة',
    };

    String getEnglishDay(String arabicDay) {
      var result1 =
          weekDaysMap.entries
              .firstWhere(
                (entry) => entry.value == arabicDay,
                orElse: () => MapEntry(arabicDay, arabicDay),
              )
              .key;
      print("result1 : $result1");

      return result1;
    }

    final Map<String, dynamic> result = {};

    state.listTimeSlot.asMap().forEach((index, value) {
      if (value.isSelected) {
        result["times[$index][day]"] = getEnglishDay(value.day ?? '');
        result["times[$index][start]"] = value.start!.replaceAll(
          RegExp(r'\s?(AM|PM)', caseSensitive: false),
          '',
        );
        result["times[$index][end]"] = value.end!.replaceAll(
          RegExp(r'\s?(AM|PM)', caseSensitive: false),
          '',
        );
      }
    });

    return result;
  }

  setMainImage(AssetEntity image) {
    state.selectedCompanyImage.value = image;
  }

  resetMainImage() {
    state.selectedCompanyImage.value = null;
  }

  resetImages() {
    state.galleryImages.value = [];
  }

  resetVideo() {
    state.video.value = null;
  }

  setImages(List<AssetEntity> images) {
    state.galleryImages.addAll(images);
    print('testfile : ${images.toString()} ${state.galleryImages.length}');
  }

  setVideo(AssetEntity video) {
    state.video.value = video;
  }

  latLngChanged(double latitude, double longitude, String? mapDesc) {
    state.lat.value = latitude;
    state.lng.value = longitude;
    state.mapDesc.value = mapDesc;
  }

  Future<Map<String, dynamic>> getRegisterData() async {
    Map<String, dynamic> result = {
      "type": state.userType.value,
      "name": state.name.text,
      "country_code": "965",
      "phone": state.phoneNumber.text,
      "email": state.email.text,
      "password": state.password.text,
      "password_confirmation": state.passwordConfirm.text,
      "image": state.selectedCompanyImage.value,
      "category_id": state.workItem.value?.id,
      "description": state.description.text,
      "direct_phone": state.phoneNumber.text,
      "commercial_registration_number": state.commercialRegistrationNumber.text,
      "whatsapp": state.whatsapp.text,
      "website": state.website.text,
      "instagram": state.instagram.text,
      "x": state.twitter.text,
      "tiktok": state.tiktok.text,
      "snapchat": state.snapchat.text,
      "youtube": state.youtube.text,
      'lat': state.lat.value,
      'lng': state.lng.value,
      'map_desc': state.mapDesc.value ?? state.mapDescGoogleDetails.text,
      ...getMapToJson(),
      'video': state.video.value,
    };
    // Main Image
    final mainImage = state.selectedCompanyImage.value;
    if (mainImage != null) {
      final file = await mainImage.file;
      if (file != null) {
        result['image'] = MultipartFile(file, filename: 'logo.jpg');
      }
    }

    // Video
    final videoAsset = state.video.value;
    if (videoAsset != null) {
      final videoFile = await videoAsset.file;
      if (videoFile != null) {
        result['video'] = MultipartFile(videoFile, filename: 'video.mp4');
      }
    }

    // Gallery Images
    final nonNullGallery = state.galleryImages.value;
    for (int i = 0; i < nonNullGallery.length; i++) {
      final asset = nonNullGallery[i];
      final file = await asset?.file;
      if (file != null) {
        result['files[$i]'] = MultipartFile(file, filename: 'gallery_$i.jpg');
      }
    }
    return result;
  }

  void setWorkCategories(OptionItem item) {
    if (item.id != null) {
      state.workItem.value = item;
    }
  }

  bool validateWorkForm() {
    if (state.phoneNumber.text.isBlank == true) {
      Utils.showSnackBar("error_phone".tr);
      return false;
    } else if (state.workItem.value?.id == null) {
      Utils.showSnackBar("error_category".tr);
      return false;
    } else if (state.description.text.isBlank == true) {
      Utils.showSnackBar("error_description".tr);
      return false;
    } else if ((state.mapDesc.value ?? state.mapDescGoogleDetails.text)
        .isEmpty) {
      Utils.showSnackBar("error_map_desc".tr);
      return false;
    } else if (state.whatsapp.text.isBlank == true) {
      Utils.showSnackBar("error_whatsapp".tr);
      return false;
    } else if (state.phoneNumber.text.isBlank == true) {
      Utils.showSnackBar("error_phone".tr);
      return false;
    } else if (state.website.text.isBlank == true) {
      Utils.showSnackBar("error_website".tr);
      return false;
    } else if (state.commercialRegistrationNumber.text.isBlank == true) {
      Utils.showSnackBar("error_crn".tr);
      return false;
    } else if (state.twitter.text.isBlank == true) {
      Utils.showSnackBar("error_twitter".tr);
      return false;
    } else if (state.instagram.text.isBlank == true) {
      Utils.showSnackBar("error_instagram".tr);
      return false;
    } else if (state.tiktok.text.isBlank == true) {
      Utils.showSnackBar("error_tiktok".tr);
      return false;
    } else if (state.snapchat.text.isBlank == true) {
      Utils.showSnackBar("error_snapchat".tr);
      return false;
    } else if (state.youtube.text.isBlank == true) {
      Utils.showSnackBar("error_youtube".tr);
      return false;
    } else if (getMapToJson().isEmpty) {
      Utils.showSnackBar("error_time_slots".tr);
      return false;
    }
    return true;
  }

  bool validateAssetForm() {
    if (state.selectedCompanyImage.value == null) {
      Utils.showSnackBar("error_image".tr);
      return false;
    } else if (state.galleryImages.value.isEmpty) {
      Utils.showSnackBar("error_gallery".tr);
      return false;
    }
    return true;
  }
}
