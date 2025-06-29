import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/my_orders_details/my_orders_details.dart';
import 'package:get/get.dart';

class OrderDetailsState {
  var orders = LoadingState<MyOrdersDetails>().obs;

  OrderDetailsState() {
    ///Initialize variables
  }
}
