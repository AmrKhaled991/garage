import 'package:get/get.dart';
import 'package:garage/utils/utlis.dart';

import 'login_state.dart';

class LoginController extends GetxController {
  final LoginState state = LoginState();

  @override
  void onInit() {
    super.onInit();
    // Listen to both controllers
    state.phoneOrEmail.value.addListener(_updateReady);
    state.password.value.addListener(_updateReady);
  }

  bool validations() {
    if (state.phoneOrEmail.value.text.isBlank == true) {
      Utils.showSnackBar("error_phone".tr);
      return false;
    } else if (state.password.value.text.isBlank == true) {
      Utils.showSnackBar("error_password".tr);
      return false;
    } else {
      return true;
    }
  }

  final _isReady = false.obs;
  bool get isReady => _isReady.value;
  void _updateReady() {
    _isReady.value =
        state.phoneOrEmail.value.text.trim().isNotEmpty &&
        state.password.value.text.isNotEmpty;
  }
}
