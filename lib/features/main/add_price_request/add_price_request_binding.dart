import 'package:garage/features/main/add_price_request/add_price_request_controller.dart';
import 'package:get/get.dart';

class AddPriceRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddPriceRequestController());
  }
}
