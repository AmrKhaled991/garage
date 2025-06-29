import 'package:garage/core/repositories/orders_repository.dart';
import 'package:get/get.dart';

import 'order_details_controller.dart';

class OrderDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrdersRepository());
    Get.put(OrderDetailsController());
  }
}
