import 'package:get/get.dart';
import 'package:garage/utils/utlis.dart';

import 'change_password_state.dart';

class ChangePasswordController extends GetxController {
  final ChangePasswordState state = ChangePasswordState();

  bool validations() {
    if (state.oldPassword.value.isBlank == true) {
      Utils.showSnackBar("error_password".tr);
      return false;
    } else if (state.password.value.isBlank == true) {
      Utils.showSnackBar("error_password".tr);
      return false;
    } else if (state.passwordConfirm.value.isBlank == true) {
      Utils.showSnackBar("error_password_confirm".tr);
      return false;
    } else if (state.password.value != state.passwordConfirm.value) {
      Utils.showSnackBar("error_password_not_match".tr);
      return false;
    } else {
      return true;
    }
  }
}
