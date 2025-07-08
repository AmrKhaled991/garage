import 'package:garage/core/repositories/orders_repository.dart';
import 'package:get/get.dart';

import 'complete_cart_order_controller.dart';

class CompleteCartOrderBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => Repo(), fenix: true);
    Get.lazyPut(() => CompleteCartOrderController(), fenix: true);
    Get.put(OrdersRepository());
  }
}
