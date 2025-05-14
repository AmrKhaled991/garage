
import 'dart:io';

import 'package:get/get.dart';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/PaymentMethod.dart';
import 'package:garage/core/networking/models/change_currency.dart';
import 'package:garage/core/networking/models/delivery_date.dart';
import 'package:garage/core/networking/models/delivery_type.dart';
import 'package:garage/core/networking/models/transfer_summary.dart';
import '../networking/base/api_response.dart';
import '../networking/base/dynamic_model.dart';
import '../networking/models/payment.dart';
import 'base_repository.dart';

class CheckoutRepository extends BaseRepository{

  UserController userController = Get.find();

  Future<LoadingState<Payment?>> createOrder(Map<String,String?> data) async{
    data["user_id"] =  userController.userToken;
    return networkHandler.postRequest(
        endpoint: "orders/create",
        create: ()=> APIResponse<Payment>(create: ()=> Payment()),
        body: FormData(data)
    );
  }

  Future<LoadingState> addDeliveryFees({int? stateId, int? addressId}) async{
    return networkHandler.postRequest(
        endpoint: "cart/add-company-delivery-fees-condition",
        create: ()=> APIDynamicResponse(create: ()=> DynamicModel()),
        body: FormData({
        "user_token" :  userController.userToken,
          if(stateId!=null) "state_id": stateId.toString(),
          if(addressId!=null) "address_id": addressId.toString(),
        })
    );
  }

  Future<LoadingState<List<DeliveryType>?>> getVendorTimes() async{
    return networkHandler.getRequest(
        endpoint: "vendors/vendor/delivery-times",
        create: ()=> APIListResponse<DeliveryType>(create: ()=> DeliveryType()),
        query: {
          "user_token" :  userController.userToken,
        }
    );
  }

  Future<LoadingState<List<PaymentMethod>?>> getPaymentMethods() async{
    return networkHandler.getRequest(
        endpoint: "orders/payment-methods",
        create: ()=> APIListResponse<PaymentMethod>(create: ()=> PaymentMethod()),
    );
  }

  Future<LoadingState<List<DeliveryDate>?>> getDeliveryDateTime() async{
    return networkHandler.getRequest(
        endpoint: "deliveryDate",
        create: ()=> APIListResponse<DeliveryDate>(create: ()=> DeliveryDate()),
    );
  }

  Future<LoadingState<TransferSummary>> getTransferSummary({String? type,String? sentAmount,String? receivedCurrencyTypeId,}) async{
    return networkHandler.postRequest(
        endpoint: "transferSummary",
        body: {
          "type": type,
          "sent_amount": sentAmount,
          "received_currency_type_id": receivedCurrencyTypeId,
        },
        create: ()=> APIResponse<TransferSummary>(create: ()=> TransferSummary()),
    );
  }

  Future<LoadingState<ChangeCurrency>> changeCurrency({String? currencyId,String? amount}) async{
    return networkHandler.postRequest(
        endpoint: "changeCurrency",
        body: {
          "currency_id": currencyId,
          "amount": amount,
        },
        create: ()=> APIResponse<ChangeCurrency>(create: ()=> ChangeCurrency()),
    );
  }

  Future<LoadingState> makeTransfer(Map<String,dynamic> body) async{
    try {
      var senderIdImagePath = body['sender_id_image'];
      var receiverIdImagePath = body['receiver_id_image'];

      body.remove('sender_id_image');
      body.remove('receiver_id_image');

      if (senderIdImagePath != null) {
        MultipartFile multipartFile = MultipartFile(
          File(senderIdImagePath ?? ""),
          filename: "sender_id_image",
        );
        body["sender_id_image"] = multipartFile;
      }

      if (receiverIdImagePath != null) {
        MultipartFile multipartFile = MultipartFile(
          File(receiverIdImagePath ?? ""),
          filename: "receiver_id_image",
        );
        body["receiver_id_image"] = multipartFile;
      }
    }catch(e){
      print(e.toString());
    }
    return networkHandler.postRequest(
        endpoint: "makeTransfer",
        body: FormData(body),
        create: ()=> APIDynamicResponse<DynamicModel>(create: ()=> DynamicModel()),
    );
  }

}