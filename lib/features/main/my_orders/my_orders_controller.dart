import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/repositories/orders_repository.dart';
import 'package:get/get.dart';

import 'my_orders_state.dart';

class MyOrdersController extends GetxController {
  final MyOrdersState state = MyOrdersState();
  final OrdersRepository ordersRepository = Get.find<OrdersRepository>();

  @override
  void onInit() {
    super.onInit();
    fetchMyOrders();
  }

  void fetchMyOrders() async {
    state.orders.value = LoadingState.loading();
    state.orders.value = await ordersRepository.getOrders();
  }
}
