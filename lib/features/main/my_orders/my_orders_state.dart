import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/Order.dart';
import 'package:garage/core/networking/models/my_order/my_order.dart';
import 'package:get/get.dart';

class MyOrdersState {
  var orders = LoadingState<List<MyOrder>?>().obs;
  MyOrdersState() {
    ///Initialize variables
  }
}
