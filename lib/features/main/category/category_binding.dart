import 'package:garage/core/repositories/categories_repository.dart';
import 'package:get/get.dart';

import 'category_controller.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CategoryController());
  }
}
