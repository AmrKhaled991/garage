import 'package:get/get.dart';

import 'terms_controller.dart';

class TermsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TermsController());
  }
}
