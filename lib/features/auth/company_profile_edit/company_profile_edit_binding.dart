import 'package:garage/features/other/select_location/select_location_controller.dart';
import 'package:get/get.dart';

import 'company_profile_edit_controller.dart';

class CompanyProfileEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CompanyProfileEditController());
    Get.lazyPut(() => SelectLocationController());
  }
}
