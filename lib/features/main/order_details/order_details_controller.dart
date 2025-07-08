import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/repositories/orders_repository.dart';
import 'package:get/get.dart';

import 'order_details_state.dart';

class OrderDetailsController extends GetxController {
  final OrderDetailsState state = OrderDetailsState();
  final OrdersRepository ordersRepository = Get.find<OrdersRepository>();

  var title = Get.arguments["screenTitle"];
  var id = Get.arguments["orderId"];

  @override
  void onInit() {
    super.onInit();
    fetchMyOrdersDetails();
  }

  void fetchMyOrdersDetails() async {
    var orderId = int.parse(id);
    print("orderId: $orderId");
    state.orders.value = LoadingState.loading();
    state.orders.value = await ordersRepository.getMyOrdersDetails(orderId);
  }
}
