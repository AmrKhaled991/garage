import 'package:flutter/material.dart';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/payment.dart';
import 'package:garage/core/repositories/orders_repository.dart';
import 'package:garage/utils/utlis.dart';
import 'package:get/get.dart';

import 'complete_cart_order_state.dart';

class CompleteCartOrderController extends GetxController {
  final CompleteCartOrderState state = CompleteCartOrderState();
  OrdersRepository ordersRepository = Get.find<OrdersRepository>();
  UserController userController = Get.find();
  // final ContactUsRepository contactUsRepository = Get.find();

  @override
  void onInit() {
    super.onInit();
    if (userController.isLogged.value) {
      state.nameController.text = userController.user.value?.name ?? "";
      state.phoneController.text = userController.user.value?.phone ?? "";
    }
  }

  bool validation() {
    if (state.nameController.text.isEmpty) {
      Utils.showSnackBar("error_name".tr);
      return false;
    } else if (state.phoneController.text.isEmpty) {
      Utils.showSnackBar("error_phone".tr);
      return false;
    } else if (state.stateController.value == null) {
      Utils.showSnackBar("Area_error".tr);
      return false;
    } else if (state.streetController.text.isEmpty) {
      Utils.showSnackBar("street_error".tr);
      return false;
    } else if (state.squareNumberController.text.isEmpty) {
      Utils.showSnackBar("square_error".tr);
      return false;
    } else if (state.jadaNumberController.text.isEmpty) {
      Utils.showSnackBar("jada_error".tr);
      return false;
    }
    return true;
  }

  /// *****  52c52a81-c425-440d-99f3-847336fa9102  ******
  void completeOrder(
    Map<String, String> data,
    Function(bool, Payment?) onFinish,
  ) async {
    state.payment.value = LoadingState.loading();
    state.payment.value = await ordersRepository.payOrder(data);
    onFinish.call(state.payment.value.success, state.payment.value.data);
  }
}
