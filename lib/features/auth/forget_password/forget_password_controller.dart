import 'package:get/get.dart';
import 'package:garage/utils/utlis.dart';

import 'forget_password_state.dart';

class ForgetPasswordController extends GetxController {
  final ForgetPasswordState state = ForgetPasswordState();

  bool validations() {
    if (state.phoneNumber.text.isBlank == true) {
      Utils.showSnackBar("error_phone".tr);
      return false;
    } else {
      return true;
    }
  }
}
