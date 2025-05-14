import 'package:get/get.dart';
import 'package:garage/core/repositories/contact_us_repository.dart';

import 'contact_us_controller.dart';

class ContactUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactUsRepository(), fenix: true);
    Get.lazyPut(() => ContactUsController(), fenix: true);
  }
}
