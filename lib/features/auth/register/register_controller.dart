import 'package:get/get.dart';
import 'package:garage/utils/utlis.dart';
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

  Map<String, dynamic> getRegisterData() {
    Map<String, dynamic> result = {
      "type": state.userType.value,
      "name": state.name.text,
      "country_code": "965",
      "phone": state.phoneNumber.text,
      "email": state.email.text,
      "password": state.password.text,
      "password_confirmation": state.passwordConfirm.text,

      "times[0][day]": "saturday",
      "times[0][start]": "09:00",
      "times[0][end]": "17:00",
      "image": state.selectedImage.value,
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
      'files[0]': state.selectedFile.value,
      'files[2]': state.selectedFile2.value,
      'video': state.selectedVideo.value,
    };
    return result;
  }
}
