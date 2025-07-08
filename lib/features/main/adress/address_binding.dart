import 'package:get/get.dart';

import 'address_controller.dart';

class UserAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserAddressController());
  }
}
