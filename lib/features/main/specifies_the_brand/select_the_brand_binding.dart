import 'package:garage/core/repositories/user_car_repository.dart';
import 'package:get/get.dart';

import 'select_the_brand_controller.dart';

class SelectTheBrandBinding extends Bindings {
  @override
  dependencies() {
    Get.put(UserCarRepository());
    Get.put(SelectTheBrandController());
  }
}
