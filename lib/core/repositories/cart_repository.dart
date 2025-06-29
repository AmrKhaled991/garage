import 'package:garage/core/networking/models/cart/data.dart';
import 'package:get/get.dart';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/networking/loading_state.dart';
import '../networking/base/api_response.dart';
import '../networking/base/dynamic_model.dart';
import 'base_repository.dart';

class CartRepository extends BaseRepository {
  UserController userController = Get.find();

  Future<LoadingState<Cart>> fetchCart() async {
    return networkHandler.getRequest(
      endpoint: "my-cart",
      create: () => APIResponse<Cart>(create: () => Cart()),
      query: {"user_token": userController.userToken},
    );
  }

  Future<LoadingState> addToCart(int productId, int quantity) async {
    return networkHandler.postRequest(
      endpoint: "add-to-cart",
      create: () => APIDynamicResponse(create: () => DynamicModel()),
      body: {
        "user_token": userController.userToken,
        "product_id": productId.toString(),
        "quantity": quantity.toString(),
      },
    );
  }

  Future<LoadingState> decreaseCartIem(int productId, int quantity) async {
    return networkHandler.postRequest(
      endpoint: "decrease-quantity",
      create: () => APIDynamicResponse(create: () => DynamicModel()),
      body: {
        "user_token": userController.userToken,
        "product_id": productId.toString(),
        "quantity": quantity.toString(),
      },
    );
  }

  Future<LoadingState> removeFromCart(String id) async {
    return networkHandler.postRequest(
      endpoint: "remove-from-cart",
      create: () => APIDynamicResponse(create: () => DynamicModel()),
      body: {
        "user_token": userController.userToken,
        "product_id": id.toString(),
      },
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
