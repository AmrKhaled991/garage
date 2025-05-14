import 'package:get/get.dart';

import 'reset_password_by_mobile_controller.dart';

class ResetPasswordByMobileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResetPasswordByMobileController());
  }
}
