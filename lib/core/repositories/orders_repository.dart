import 'package:garage/core/networking/models/my_order/my_order.dart';
import 'package:garage/core/networking/models/my_orders_details/my_orders_details.dart';
import 'package:garage/core/networking/models/payment.dart';
import 'package:garage/core/networking/models/user_prices_request/user_prices_request.dart';
import 'package:garage/core/storage/preference_manager.dart';
import 'package:get/get.dart';
import 'package:garage/core/networking/loading_state.dart';
import '../networking/base/api_response.dart';
import 'base_repository.dart';

class OrdersRepository extends BaseRepository {
  PreferenceManager preferenceManager = Get.find();

  Future<LoadingState<Payment?>> payOrder(Map<String, String> body) async {
    return networkHandler.postRequest(
      endpoint: "store-order",
      body: body,
      create: () => APIResponse<Payment>(create: () => Payment()),
    );
  }

  // Future<LoadingState<CouponData?>> checkCoupon(
  //   String? reservationId,
  //   String? couponCode,
  // ) async {
  //   return networkHandler.postRequest(
  //     endpoint: "check/coupon/$reservationId",
  //     body: {"coupon_code": couponCode},
  //     create: () => APIResponse<CouponData>(create: () => CouponData()),
  //   );
  // }

  Future<LoadingState<List<MyOrder>?>> getOrders() async {
    return networkHandler.getRequest(
      endpoint: "my-orders",
      create: () => APIListResponse<MyOrder>(create: () => MyOrder()),
    );
  }

  Future<LoadingState<List<UserPricesRequest>?>> getMyPriceRequests({
    int? page = 1,
  }) async {
    return networkHandler.getRequest(
      endpoint: "my-price-requests?page=$page",
      create: () => APIListResponse<UserPricesRequest>(create: () => UserPricesRequest()),
    );
  }

  Future<LoadingState<MyOrdersDetails>> getMyOrdersDetails(int id) async {
    return networkHandler.getRequest(
      endpoint: "order-details/$id",
      create:
          () => APIResponse<MyOrdersDetails>(create: () => MyOrdersDetails()),
    );
  }
}
