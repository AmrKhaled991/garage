import 'package:garage/core/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:garage/utils/utlis.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'profile_edit_state.dart';

class ProfileEditController extends GetxController {
  final ProfileEditState state = ProfileEditState();
  UserController userController = Get.find();
  final isChanging = false.obs;

  bool validations() {
    if (state.name.value.isBlank == true) {
      Utils.showSnackBar("error_name".tr);
      return false;
    } else if (state.phoneNumber.value.isBlank == true) {
      Utils.showSnackBar("error_phone".tr);
      return false;
    } else if (state.email.value.isBlank == true) {
      Utils.showSnackBar("error_email".tr);
      return false;
    } else {
      return true;
    }
  }

  @override
  void onInit() {
    var user = userController.user.value;
    if (user != null) {
      state.name.value.text = user.name ?? "";
      state.phoneNumber.value.text = user.phone ?? "";
      state.email.value.text = user.email ?? "";
    }
    state.phoneNumber.value.addListener(isProfileChanged);
    state.email.value.addListener(isProfileChanged);
    state.name.value.addListener(isProfileChanged);
    super.onInit();
  }

  bool isProfileChanged() {
    bool changed =
        (userController.user.value?.phone != state.phoneNumber.value.text ||
            userController.user.value?.email != state.email.value.text ||
            userController.user.value?.name != state.name.value.text ||
            state.selectedAvatarImage.value != null);
    isChanging.value = changed;
    return changed;
  }

  updateUserProfileImage(AssetEntity image) {
    state.selectedAvatarImage.value = image;
    isChanging.value = true;
    update();
    isProfileChanged();
  }

  Map<String, dynamic> requestData() {
    Map<String, dynamic> data = {
      "email": state.email.value.text,
      "name": state.name.value.text,
      "country_code": "965",
      "phone": state.phoneNumber.value.text,
      "image": state.selectedAvatarImage.value,
    };
    return data;
  }

  updateProfile({required Function(bool) onFinish}) async {
    if (!validations()) {
      onFinish.call(false);
      return;
    }
    userController.updateProfile(requestData(), (success) {
      onFinish.call(success);
    });
  }
}
