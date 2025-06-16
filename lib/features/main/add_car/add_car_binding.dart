import 'package:garage/core/repositories/user_car_repository.dart';
import 'package:get/get.dart';

import 'add_car_controller.dart';

class AddCarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddCarLogic());
    Get.lazyPut(() => UserCarRepository());
  }
}
