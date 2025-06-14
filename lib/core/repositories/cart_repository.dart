import 'package:get/get.dart';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/cart.dart';
import '../networking/base/api_response.dart';
import '../networking/base/dynamic_model.dart';
import 'base_repository.dart';

class CartRepository extends BaseRepository {
  UserController userController = Get.find();

  Future<LoadingState<Cart>> fetchCart() async {
    return networkHandler.getRequest(
      endpoint: "cart",
      create: () => APIResponse<Cart>(create: () => Cart()),
      query: {"user_token": userController.userToken},
    );
  }

  Future<LoadingState> addToCart(Map<String, String> data) async {
    data["user_token"] = userController.userToken ?? "";
    return networkHandler.postRequest(
      endpoint: "cart/add-or-update",
      create: () => APIDynamicResponse(create: () => DynamicModel()),
      body: FormData(data),
    );
  }

  Future<LoadingState> removeFromCart(String id) async {
    return networkHandler.postRequest(
      endpoint: "cart/remove/$id",
      create: () => APIDynamicResponse(create: () => DynamicModel()),
      body: {"user_token": userController.userToken},
    );
  }

  Future<LoadingState> clearCart() async {
    return networkHandler.postRequest(
      endpoint: "cart/clear",
      create: () => APIDynamicResponse(create: () => DynamicModel()),
      body: {"user_token": userController.userToken},
    );
  }

  Future<LoadingState> checkCoupon(String? coupon) async {
    return networkHandler.postRequest(
      endpoint: "coupons/check_coupon",
      create: () => APIDynamicResponse(create: () => DynamicModel()),
      body: {
        "user_token": userController.userToken,
        if (coupon != null) "code": coupon,
      },
    );
  }

  Future<LoadingState> removeCoupon() async {
    return networkHandler.postRequest(
      endpoint: "cart/remove-condition/coupon_discount",
      create: () => APIDynamicResponse(create: () => DynamicModel()),
      body: {"user_token": userController.userToken},
    );
  }
}
