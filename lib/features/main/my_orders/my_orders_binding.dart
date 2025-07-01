import 'package:garage/core/repositories/orders_repository.dart';
import 'package:get/get.dart';

import 'my_orders_controller.dart';

class MyOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrdersRepository());

    Get.lazyPut(() => MyOrdersController());
  }
}
