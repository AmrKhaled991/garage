import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:garage/core/networking/base/pagination.dart';

import 'decodable.dart';
import 'package:garage/core/networking/base/meta.dart';

///A function that creates an object of type [T]

typedef Create<T> = T Function();

///Construct to get object from generic class

abstract class GenericObject<T> {
  Create<Decodable> create;

  GenericObject({required this.create});

  T genericObject(dynamic data) {
    final item = create();
    return item.decode(data);
  }
}

///Construct to wrap response from API.
///
///Used it as return object of APIController to handle any kind of response.

// key values in base response
// case 'success':
// $code = 200;
// case 'fail':
// $code = 400;
// case 'needActive':
// $code = 203;
// case 'unauthorized':
// $code = 400;
// case 'unauthenticated':
// $code = 401;
// case 'blocked':
// $code = 423;
// case 'exception':
// $code = 500;

class ResponseWrapper<T> extends GenericObject<T> {
  T? response;

  ResponseWrapper({required Create<Decodable> create}) : super(create: create);

  factory ResponseWrapper.init({
    required Create<Decodable> create,
    required dynamic data,
  }) {
    final wrapper = ResponseWrapper<T>(create: create);
    wrapper.response = wrapper.genericObject(data);
    return wrapper;
  }
}

class APIResponse<T> extends GenericObject<T>
    implements Decodable<APIResponse<T>> {
  String? key;
  String? message;
  T? data;

  APIResponse({required Create<Decodable> create}) : super(create: create);

  @override
  APIResponse<T> decode(dynamic json) {
    key = json['key'];
    message = json['message'];
    data = genericObject(json['data']);
    return this;
  }
}

class APIDynamicResponse<T> extends GenericObject<T>
    implements Decodable<APIDynamicResponse<T>> {
  String? key;
  String? message;
  dynamic data;

  APIDynamicResponse({required Create<Decodable> create})
    : super(create: create);

  @override
  APIDynamicResponse<T> decode(dynamic json) {
    key = json['key'];
    message = json['message'];
    data = json['data'];
    return this;
  }
}

class APIListResponse<T> extends GenericObject<T>
    implements Decodable<APIListResponse<T>> {
  String? key;
  String? message;
  List<T>? data;
  Pagination? pagination;

  APIListResponse({required Create<Decodable> create}) : super(create: create);

  @override
  APIListResponse<T> decode(dynamic json) {
    key = json['key'];
    message = json['message'];
    data = [];
    json['data'].forEach((item) {
      data?.add(genericObject(item));
    });
    pagination =
        json['pagination'] != null
            ? Pagination.fromJson(json['pagination'])
            : null;
    return this;
  }
}

class ErrorResponse implements Exception {
  String? message;

  ErrorResponse({this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(message: json['message'] ?? "error_try_again".tr);
  }

  @override
  String toString() {
    return message ?? 'Failed to convert message to string.';
  }
}
