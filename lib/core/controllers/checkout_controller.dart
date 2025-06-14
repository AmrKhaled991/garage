import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:garage/core/controllers/cart_controller.dart';
import 'package:garage/core/controllers/main_controller.dart';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/address.dart';
import 'package:garage/core/networking/models/delivery_type.dart';
import 'package:garage/core/networking/models/payment.dart';
import 'package:garage/core/repositories/checkout_repository.dart';
import 'package:garage/core/storage/preference_manager.dart';
import 'package:garage/utils/utlis.dart';

class CheckoutController extends GetxController {
  final PreferenceManager sharedPreferenceRepository = Get.find();
  UserController userController = Get.find();
  CartController cartController = Get.find();
  CheckoutRepository checkoutRepository = Get.find();
  MainController mainController = Get.find();

  @override
  void onReady() {
    super.onReady();
  }

  var checkoutLoading = LoadingState<Payment?>().obs;

  var orderAddress = Rx<AddressData?>(null);

  // var deliveryType = DeliveryType.IN_TIME.obs;
  var selectedPaymentMethod = "cash".obs;
  var paymentAllAmount = "1".obs;
  var selectedDeliveryType = Rx<DeliveryType?>(null);

  var selectedTime = Rx<TimesData?>(null);
  var selectedDate = Rx<String?>(null);

  var couponLoading = LoadingState().obs;
  var couponCode = "".obs;
  var couponError = "".obs;

  var coupon = 0.0.obs;

  void checkout(Function(bool, Payment?) success) async {
    if (userController.isLogged.value) {
      authCheckout(success);
    } else {
      guestCheckout(success);
    }
  }

  void guestCheckout(Function(bool, Payment?) success) async {
    Map<String, String?> data = {
      "address[username]": orderAddress.value?.username,
      "address[email]": orderAddress.value?.email,
      "address[mobile]": orderAddress.value?.mobile,
      "address[block]": orderAddress.value?.block,
      "address[street]": orderAddress.value?.street,
      "address[address]": orderAddress.value?.additions,
      "address[avenue]": orderAddress.value?.avenue,
      "address[floor]": orderAddress.value?.floor,
      "address[flat]": orderAddress.value?.flat,
      "address[building]": orderAddress.value?.building,
      "address[state_id]": orderAddress.value?.stateId.toString(),
      "payment": selectedPaymentMethod.value,
      "address_type": "guest_address",
      "shipping[type]": selectedTime.value != null ? "schedule" : "direct",
      "paid_full_amount": paymentAllAmount.value,
    };
    if (selectedTime.value != null) {
      data["shipping[date]"] = selectedDate.value ?? "";
      data["shipping[time_from]"] = selectedTime.value?.timeFrom ?? "";
      data["shipping[time_to]"] = selectedTime.value?.timeTo ?? "";
    }
    checkoutLoading.value = LoadingState.loading();
    checkoutLoading.value = await checkoutRepository.createOrder(data);
    if (checkoutLoading.value.success) {
      success.call(true, checkoutLoading.value.data);
    } else {
      success.call(false, null);
      Utils.showSnackBar(checkoutLoading.value.message);
    }
  }

  void authCheckout(Function(bool, Payment?) success) async {
    Map<String, String?> data = {
      "address_id": orderAddress.value?.id.toString(),
      "state_id": orderAddress.value?.stateId.toString(),
      "payment": selectedPaymentMethod.value,
      "address_type": "selected_address",
      "shipping[type]": selectedTime.value != null ? "schedule" : "direct",
      "paid_full_amount": paymentAllAmount.value,
    };
    if (selectedTime.value != null) {
      data["shipping[date]"] = selectedDate.value ?? "";
      data["shipping[time_from]"] = selectedTime.value?.timeFrom ?? "";
      data["shipping[time_to]"] = selectedTime.value?.timeTo ?? "";
    }
    checkoutLoading.value = LoadingState.loading();
    checkoutLoading.value = await checkoutRepository.createOrder(data);
    if (checkoutLoading.value.success) {
      success.call(true, checkoutLoading.value.data);
    } else {
      success.call(false, null);
      Utils.showSnackBar(checkoutLoading.value.message);
    }
  }

  void addDeliveryFees({
    int? stateId,
    int? addressId,
    Function(bool)? onFinish,
  }) async {
    var response = await checkoutRepository.addDeliveryFees(
      addressId: addressId,
      stateId: stateId,
    );
    onFinish?.call(response.success);
    if (response.success) {
      cartController.getCartItems(true);
    } else {
      Utils.showSnackBar(response.message);
    }
  }

  void checkCoupon() async {
    couponLoading.value = LoadingState.loading();

    couponLoading.value = await cartController.cartRepository.checkCoupon(
      couponCode.value,
    );
    if (couponLoading.value.success) {
      if (couponLoading.value.success == true) {
        Utils.showSnackBar("coupon_added".tr);
        cartController.getCartItems(true);
      } else {
        Utils.showSnackBar(couponLoading.value.message);
      }
    } else {
      Utils.showSnackBar(couponLoading.value.message);
    }
  }

  void removeCoupon({bool withLoading = true}) async {
    if (withLoading) couponLoading.value = LoadingState.loading();
    couponLoading.value = await cartController.cartRepository.removeCoupon();
    if (couponLoading.value.success) {
      cartController.getCartItems(true);
    }
  }
}

//
// enum DeliveryType{IN_TIME,LATER}
//
// enum PaymentMethod{CASH,ONLINE}
