import 'package:get/get.dart';
import 'package:garage/utils/utlis.dart';
import 'reset_password_by_mobile_state.dart';

class ResetPasswordByMobileController extends GetxController {
  final ResetPasswordByMobileState state = ResetPasswordByMobileState();

  bool validations() {
    if (state.code.value.isBlank == true) {
      Utils.showSnackBar("error_code".tr);
      return false;
    } else if (state.password.value.isBlank == true) {
      Utils.showSnackBar("error_password".tr);
      return false;
    } else if (state.passwordConfirm.value.isBlank == true) {
      Utils.showSnackBar("error_password_confirm".tr);
      return false;
    } else if (state.password.value != state.passwordConfirm.value) {
      Utils.showSnackBar("error_not_match".tr);
      return false;
    } else {
      return true;
    }
  }
}
