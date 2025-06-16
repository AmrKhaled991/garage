import 'dart:math';

import 'package:garage/features/auth/company_profile_edit/models/time_slot.dart';
import 'package:get/get.dart';
import 'package:garage/utils/utlis.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'register_state.dart';

class RegisterController extends GetxController {
  final RegisterState state = RegisterState();

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
    if (state.listTimeSlot.contains(timeSlot)) {
      state.listTimeSlot.removeWhere((e) => e.day == timeSlot.day);
      return;
    } else {
      state.listTimeSlot.add(timeSlot);
    }
  }

  Map<String, dynamic> getMapToJson() {
    final Map<String, dynamic> result = {};

    state.listTimeSlot.asMap().forEach((index, value) {
      result["times[$index][day]"] = value.day;
      result["times[$index][start]"] = value.start;
      result["times[$index][end]"] = value.end;
    });

    return result;
  }

  setMainImage(AssetEntity image) {
    state.selectedCompanyImage.value = image;
  }

  resetMainImage() {
    state.selectedCompanyImage.value = null;
  }

  setImages(AssetEntity images) {
    state.galleryImages.value.add(images);
  }

  setVideo(AssetEntity video) {
    state.video.value = video;
  }

  Map<String, dynamic> getRegisterData() {
    Map<String, dynamic> result = {
      "type": state.userType.value,
      "name": state.name.text,
      "country_code": "965",
      "phone": state.phoneNumber.text,
      "email": state.email.text,
      "password": state.password.text,
      "password_confirmation": state.passwordConfirm.text,
      ...getMapToJson(),
      "image": state.selectedCompanyImage.value,
      "work_type_id": state.workTypeId.value,
      "description": state.description.text,
      "direct_phone": state.directPhone.text,
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
      'map_desc': state.mapDesc.text,
      // 'files[0]': state.selectedFile.value,
      // 'files[2]': state.selectedFile2.value,
      // 'video': state.selectedVideo.value,
    };
    return result;
  }
}
