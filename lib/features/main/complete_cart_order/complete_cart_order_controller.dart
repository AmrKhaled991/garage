import 'package:flutter/material.dart';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/utils/utlis.dart';
import 'package:get/get.dart';

import 'complete_cart_order_state.dart';

class CompleteCartOrderController extends GetxController {
  final CompleteCartOrderState state = CompleteCartOrderState();
  UserController userController = Get.find();
  // final ContactUsRepository contactUsRepository = Get.find();

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
    } else if (state.stateController.text.isEmpty) {
      Utils.showSnackBar("state_message".tr);
      return false;
    } else if (state.streetController.text.isEmpty) {
      Utils.showSnackBar("street_message".tr);
      return false;
    } else if (state.squareNumberController.text.isEmpty) {
      Utils.showSnackBar("square_message".tr);
      return false;
    } else if (state.jadaNumberController.text.isEmpty) {
      Utils.showSnackBar("jada_message".tr);
      return false;
    }
    return true;
  }

  /*******  52c52a81-c425-440d-99f3-847336fa9102  *******/
  void completeOrder(Map<String, String> data, Function(bool) onFinish) async {
    // state.contactUsLoading.value = LoadingState.loading();
    // state.contactUsLoading.value = await contactUsRepository.contactUs(data);
    // onFinish.call(state.contactUsLoading.value.success);
    // if (state.contactUsLoading.value.success == false) {
    //   Utils.showSnackBar(state.contactUsLoading.value.message);
    //  }
    onFinish.call(state.completeOrderLoading.value.success);
    if (state.completeOrderLoading.value.success == false) {
      Utils.showSnackBar(state.completeOrderLoading.value.message);
    }
  }
}
