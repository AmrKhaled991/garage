
import 'package:garage/core/networking/base/dynamic_model.dart';
import 'package:garage/core/networking/models/Order.dart';
import 'package:garage/core/networking/models/my_reservation.dart';
import 'package:garage/core/networking/models/my_transaction.dart';
import 'package:garage/core/networking/models/payment.dart';
import 'package:garage/core/storage/preference_manager.dart';
import 'package:get/get.dart';
import 'package:garage/core/networking/loading_state.dart';
import '../networking/base/api_response.dart';
import '../networking/models/coupon.dart';
import '../networking/models/times.dart';
import 'base_repository.dart';


class OrdersRepository extends BaseRepository{
  PreferenceManager preferenceManager = Get.find();


  Future<LoadingState<Payment?>> createReservation(String? doctorId, Map<String,String> body) async{
    return networkHandler.postRequest(
      endpoint: "reservation/$doctorId",
      body: body,
      create: ()=> APIResponse<Payment>(create: ()=> Payment()),
    );
  }

  Future<LoadingState<Payment?>> reservationPayment(String? reservationId, String? paymentMethod, String? couponCode) async{
    return networkHandler.postRequest(
      endpoint: "reservation/pay/$reservationId",
      body: {
        "payment_method": paymentMethod??"upayment",
        if(couponCode?.isNotEmpty == true)
        "coupon_code": couponCode
      },
      create: ()=> APIResponse<Payment>(create: ()=> Payment()),
    );
  }

  Future<LoadingState<CouponData?>> checkCoupon(String? reservationId, String? couponCode) async{
    return networkHandler.postRequest(
      endpoint: "check/coupon/$reservationId",
      body: {
        "coupon_code": couponCode
      },
      create: ()=> APIResponse<CouponData>(create: ()=> CouponData()),
    );
  }

  Future<LoadingState<Times?>> getDoctorTimes(String? doctorId, String? date) async{
    return networkHandler.postRequest(
      endpoint: "doctor/dates/$doctorId",
      body: {
        "date": date
      },
      create: ()=> APIResponse<Times>(create: ()=> Times()),
    );
  }

  Future<LoadingState<List<MyReservation>?>> getReservations({String? type}) async{
    return networkHandler.getRequest(
        endpoint: type == "previous"? "previous/reservations" : "current/reservations",
      create: ()=> APIListResponse<MyReservation>(create: ()=> MyReservation()),
    );
  }

  Future<LoadingState<List<OrderData>?>> getOrders() async{
    return networkHandler.getRequest(
        endpoint: "orders/list",
      create: ()=> APIListResponse<OrderData>(create: ()=> OrderData()),
    );
  }

  Future<LoadingState<List<MyTransaction>?>> getMyTransaction({int page = 1}) async{
    return networkHandler.getRequest(
        endpoint: "myTransactions",
      query: {"page": page.toString()},
      create: ()=> APIListResponse<MyTransaction>(create: ()=> MyTransaction()),
    );
  }

  Future<LoadingState<MyTransaction?>> getTransactionById(String id) async{
    return networkHandler.postRequest(
        endpoint: "showTransferById",
      body: {"transfer_id": id},
      create: ()=> APIResponse<MyTransaction>(create: ()=> MyTransaction()),
    );
  }

  Future<LoadingState<Payment?>> payTransaction(String id) async{
    return networkHandler.postRequest(
        endpoint: "send-money",
      body: {"transfer_id": id},
      create: ()=> APIResponse<Payment>(create: ()=> Payment()),
    );
  }

  Future<LoadingState> rateOrder(String id, String rate) async{
    return networkHandler.postRequest(
        endpoint: "orders/$id/rates",
        create: ()=> APIDynamicResponse(create: ()=> DynamicModel()),
        body: {
        "rating": rate
      }
    );
  }


}