import 'package:garage/core/repositories/home_repository.dart';
import 'package:garage/core/repositories/user_car_repository.dart';
import 'package:garage/features/main/home/home_logic.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class HomePageBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => HomeRepository());
    Get.lazyPut(() => UserCarRepository());
  }
}
