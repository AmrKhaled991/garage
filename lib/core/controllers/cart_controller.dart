import 'package:flutter/material.dart';
import 'package:garage/core/networking/models/cart/data.dart';
import 'package:get/get.dart';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/repositories/cart_repository.dart';
import 'package:garage/core/storage/preference_manager.dart';
import 'package:garage/utils/utlis.dart';

import '../networking/models/product.dart';

class CartController extends GetxController {
  final PreferenceManager sharedPreferenceRepository = Get.find();
  UserController userController = Get.find();
  CartRepository cartRepository = Get.find();

  @override
  /*************  ✨ Windsurf Command ⭐  *************/
  ///
  /// Called when the widget is inserted into the tree.
  ///
  /// Listens to cartItems and updates isEmpty and cartCount accordingly.
  /// If the cart is not empty, sorts the items by id and updates
  /// the cartCount with the number of items in the cart.
  /// If the cart is empty, sets isEmpty to true and cartCount to 0.
  ///
  /// *****  89b4d099-1600-4e9e-8018-3c3029cf0991  ******
  void onReady() {
    super.onReady();

    cart.listen((cart) {
      if (cart.data != null &&
          cart.data != null &&
          cart.data?.items?.isNotEmpty == true &&
          !this.cart.value.loading) {
        if (isEmpty.value) isEmpty.value = false;
        cart.data?.items?.sort(
          (a, b) => a.id.toString().compareTo(b.id.toString()),
        );
        cartCount.value = cart.data?.items?.length ?? 0;
      } else {
        if (!isEmpty.value && !this.cart.value.loading) isEmpty.value = true;
        cartCount.value = 0;
      }
    });
  }

  var cart = LoadingState<Cart?>().obs;
  var addToCartLoading = LoadingState().obs;
  var removeFromCartLoading = LoadingState().obs;
  var decreaseCartItemLoading = LoadingState().obs;
  var cartCount = 0.obs;
  var isEmpty = true.obs;

  // var deliveryType = DeliveryType.IN_TIME.obs;
  // var paymentMethod = PaymentMethod.CASH.obs;

  var selectedTime = "".obs;
  var selectedDate = DateTime.now().obs;

  // var couponLoading = LoadingState<bool>().obs;
  // var couponCode = "".obs;
  // var couponError = "".obs;
  //
  // var coupon = 0.0.obs;

  void addToCart(
    // Map<String, String> data,
    // Map<int, AddonOptions?> singleOptions,
    // Map<int, List<AddonOptions?>> multiOptions
    int productId,
    int quantity, {
    Function(bool)? onFinish,
  }) async {
    // //add options to body

    // singleOptions.values.toList().asMap().forEach((index, value) {
    //   data["addonsOptions[$index][id]"] =
    //       singleOptions.keys.elementAt(index).toString();
    //   data["addonsOptions[$index][options][]"] = value?.id?.toString() ?? "";
    // });

    // multiOptions.values.toList().asMap().forEach((index, value) {
    //   if (value.isNotEmpty) {
    //     data["addonsOptions[${singleOptions.length + index}][id]"] =
    //         multiOptions.keys.elementAt(index).toString();
    //     value.asMap().forEach((i, value) {
    //       data["addonsOptions[${singleOptions.length + index}][options][$i]"] =
    //           value?.id?.toString() ?? "";
    //     });
    //   }
    // });

    addToCartLoading.value = LoadingState.loading();
    addToCartLoading.value = await cartRepository.addToCart(
      productId,
      quantity,
    );
    onFinish?.call(addToCartLoading.value.success);
    if (addToCartLoading.value.success) {
      getCartItems(true);
      Utils.showSnackBar("success_add_product_to_cart".tr);
    } else {
      Utils.showSnackBar(addToCartLoading.value.message);
    }
  }

  void decreaseCartIem(
    int productId,
    int quantity, {
    Function(bool)? onFinish,
  }) async {
    decreaseCartItemLoading.value = LoadingState.loading();
    decreaseCartItemLoading.value = await cartRepository.decreaseCartIem(
      productId,
      quantity,
    );
    onFinish?.call(decreaseCartItemLoading.value.success);
    if (decreaseCartItemLoading.value.success) {
      getCartItems(true);
    } else {
      Utils.showSnackBar(decreaseCartItemLoading.value.message);
    }
  }

  void removeFromCart(String productId) async {
    removeFromCartLoading.value = LoadingState.loading();
    removeFromCartLoading.value = await cartRepository.removeFromCart(
      productId,
    );
    if (removeFromCartLoading.value.success) {
      getCartItems(true);
    } else {
      Utils.showSnackBar(addToCartLoading.value.message);
    }
  }

  void clearCart() async {
    var response = await cartRepository.clearCart();
    if (response.success) {
      getCartItems(true);
    } else {
      Utils.showSnackBar(response.message);
    }
  }

  // void checkout(Map<String,dynamic> data,Function(Map<String,dynamic>) success) async{
  //   checkoutLoading.value = LoadingState.loading();
  //   var response = await cartRepository.createOrder(data);
  //   if(response.success) {
  //     checkoutLoading.value = LoadingState.success(true);
  //     success.call(response.data);
  //     getCartItems(true);
  //   }else{
  //     checkoutLoading.value = LoadingState.errorNoRetry(message:response.message);
  //     Get.snackbar("alert".tr, checkoutLoading.value.message,backgroundColor: Colors.black, colorText: Colors.white,padding: EdgeInsets.all(24),);
  //   }
  // }
  //
  void getCartItems(bool? noLoading) async {
    if (noLoading == false) cart.value = LoadingState.loading();
    cart.value = await cartRepository.fetchCart();
    if (noLoading == false) {
      cart.value.loading = false;
      update();
    }
  }

  // void checkCoupon(String successMsg, String noDiscountMsg) async{
  //   couponLoading.value = LoadingState.loading();
  //   Map<String,String> data = Map();
  //   data["code"] = couponCode.value;
  //
  //   couponLoading.value = await cartRepository.checkCoupon(data);
  //   if(couponLoading.value.success){
  //     if(couponLoading.value.data == true){
  //       Get.snackbar("alert".tr, successMsg,backgroundColor: Colors.black, colorText: Colors.white,padding: EdgeInsets.all(24),);
  //       getCartItems(true);
  //     }else{
  //       Get.snackbar("alert".tr, noDiscountMsg,backgroundColor: Colors.black, colorText: Colors.white,padding: EdgeInsets.all(24),);
  //     }
  //   }else{
  //     Get.snackbar("alert".tr, couponLoading.value.message,backgroundColor: Colors.black, colorText: Colors.white,padding: EdgeInsets.all(24),);
  //   }
  // }
  //
  // void removeCoupon({bool withLoading = true}) async{
  //   if(withLoading)
  //     couponLoading.value = LoadingState.loading();
  //   couponLoading.value = await cartRepository.removeCoupon();
  //   if(couponLoading.value.success){
  //     getCartItems(true);
  //   }
  // }
  //
  // double totalCartWithoutCoupon() {
  //   var subTotal = double.tryParse(cartItems.value.data.data.subTotal);
  //   var couponDiscount = double.tryParse(cartItems.value?.data?.data?.couponValue??"0").abs();
  //   print("totalCartWithoutCoupon = ${subTotal + couponDiscount}");
  //   return subTotal + couponDiscount;
  // }
}

//
// enum DeliveryType{IN_TIME,LATER}
//
// enum PaymentMethod{CASH,ONLINE}
