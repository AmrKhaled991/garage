import 'package:get/get.dart';

import 'select_location_controller.dart';

class SelectLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SelectLocationController());
  }
}
