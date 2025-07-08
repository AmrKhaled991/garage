import 'dart:developer';

import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/networking/base/api_response.dart';
import 'package:garage/core/networking/base/decodable.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:get/get.dart' hide Response;
import 'package:garage/core/storage/preference_manager.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/utils/utlis.dart';
import 'package:get/get_connect.dart';

class NetworkHandler extends GetConnect {
  PreferenceManager preferenceManager = Get.find();

  String BASE_URL = "https://garage.tocaan.net/api/";

  @override
  void onInit() {
    httpClient.baseUrl = BASE_URL;
    httpClient.timeout = const Duration(hours: 1);
  }

  static getHeaders() {
    return {
      if (Get.find<PreferenceManager>().getAccessToken.isNotEmpty == true)
        "Authorization":
            "Bearer ${Get.find<PreferenceManager>().getAccessToken}",
      "Accept-Language": Get.find<PreferenceManager>().getLocale,
      "Lang": Get.find<PreferenceManager>().getLocale,
      "Accept": "application/json",
    };
  }

  Future<LoadingState<ResultType>> getRequest<M extends Decodable, ResultType>({
    required String endpoint,
    required Create<M> create,
    Map<String, dynamic>? query,
  }) async {
    var response = await get(endpoint, query: query, headers: getHeaders());
    log(
      "***************GET $endpoint ,query: $query , headers: ${getHeaders().toString()} , url: ${response.request?.url} ***************",
    );
    log(
      "***************GET $endpoint Response (${response.statusCode}) ***************\n${response.body}",
    );

    return handleResponse<M, ResultType>(response, create);
  }

  Future<LoadingState<ResultType>> postRequest<
    M extends Decodable,
    ResultType
  >({required String endpoint, required Create<M> create, dynamic body}) async {
    var response = await post(endpoint, body, headers: getHeaders());
    log(
      "***************POST $endpoint ,body: $body , headers: ${getHeaders().toString()} , url: ${response.request?.url} ***************",
    );
    log(
      "***************POST $endpoint Response (${response.statusCode}) ***************\n${response.body}",
    );

    return handleResponse<M, ResultType>(response, create);
  }

  Future<LoadingState<ResultType>> patchRequest<
    M extends Decodable,
    ResultType
  >({required String endpoint, required Create<M> create, dynamic body}) async {
    var response = await patch(endpoint, body, headers: getHeaders());
    log(
      "***************PATCH $endpoint ,body: $body , headers: ${getHeaders().toString()} , url: ${response.request?.url} ***************",
    );
    log(
      "***************PATCH $endpoint Response (${response.statusCode}) ***************\n${response.body}",
    );

    return handleResponse<M, ResultType>(response, create);
  }

  Future<LoadingState<ResultType>> putRequest<M extends Decodable, ResultType>({
    required String endpoint,
    required Create<M> create,
    dynamic body,
  }) async {
    var response = await put(endpoint, body, headers: getHeaders());
    log(
      "***************PUT $endpoint ,body: $body , headers: ${getHeaders().toString()} , url: ${response.request?.url} ***************",
    );
    log(
      "***************PUT $endpoint Response (${response.statusCode}) ***************\n${response.body}",
    );

    return handleResponse<M, ResultType>(response, create);
  }

  Future<LoadingState<ResultType>>
  deleteRequest<M extends Decodable, ResultType>({
    required String endpoint,
    required Create<M> create,
    Map<String, dynamic>? query,
  }) async {
    var response = await delete(endpoint, query: query, headers: getHeaders());
    log(
      "***************DELETE $endpoint ,query: $query , headers: ${getHeaders().toString()} , url: ${response.request?.url} ***************",
    );
    log(
      "***************DELETE $endpoint Response (${response.statusCode}) ***************\n${response.body}",
    );

    return handleResponse<M, ResultType>(response, create);
  }

  LoadingState<ResultType> handleResponse<M extends Decodable, ResultType>(
    Response? response,
    Create<M> create,
  ) {
    try {
      if (response?.body == null) {
        return LoadingState.errorNoRetry(message: "error_try_again".tr);
      }

      if (response?.isOk == true) {
        ResponseWrapper responseWrapper = ResponseWrapper.init(
          create: create,
          data: response?.body,
        );

        return LoadingState.success(
          responseWrapper.response.data as ResultType?,
          pagination:
              (responseWrapper.response is APIListResponse)
                  ? responseWrapper.response.pagination
                  : null,
          message: responseWrapper.response.message ?? "",
          key: responseWrapper.response.key ?? "",
        );
      } else {
        if (response?.body["key"] == "unauthenticated") {
          if (Get.currentRoute != Routes.LOGIN) {
            Get.toNamed(Routes.LOGIN);
            Get.find<UserController>().logout();
          }
        } else if (response?.body["key"] == "needActive") {
          if (Get.currentRoute != Routes.OTP_VERIFY) {
            Get.offAndToNamed(Routes.OTP_VERIFY);
          }
        }
        return LoadingState.errorNoRetry(
          message: Utils.getErrorFromJson(response?.body),
        );
      }
    } catch (e) {
      log("handleResponse catch error: ${e.toString()}");
      return LoadingState.errorNoRetry(
        message: "${"error_try_again".tr}\n${e.toString()}",
      );
    }
  }
}
