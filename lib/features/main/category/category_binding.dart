import 'package:get/get.dart';

import 'category_comtroller.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryController(), fenix: true);
  }
}
