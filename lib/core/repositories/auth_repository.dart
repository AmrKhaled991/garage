import 'dart:io';
import 'package:garage/core/networking/base/api_response.dart';
import 'package:garage/core/networking/base/dynamic_model.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/user.dart';
import 'package:garage/core/networking/models/wallet.dart';
import 'package:garage/core/storage/preference_manager.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'base_repository.dart';
import 'package:path/path.dart';

class AuthRepository extends BaseRepository {
  Future<LoadingState<User>> login(
    Map<String, String> body, {
    bool withPhone = false,
  }) async {
    body["device_type"] = Platform.isAndroid ? "android" : "ios";
    body["device_id"] = Platform.isAndroid ? "android" : "ios";
    return networkHandler.postRequest(
      endpoint: "sign-in",
      create: () => APIResponse<User>(create: () => User()),
      body: body,
    );
  }

  Future<LoadingState<User?>> register(Map<String, dynamic> body) async {
    Map<String, dynamic> b = {};

    // if (body["image"] != null && body["image"] is AssetEntity) {
    //   File? file = await body["image"].file;
    //   MultipartFile multipartFile = MultipartFile(file, filename: "image");
    //   b["image"] = multipartFile;
    //   body.remove("image");
    // }
    if (body["cover"] != null && body["cover"] is AssetEntity) {
      File? file = await body["cover"].file;
      MultipartFile multipartFile = MultipartFile(file, filename: "cover");
      b["cover"] = multipartFile;
      body.remove("cover");
    }
    // if (body["video"] != null && body["video"] is AssetEntity) {
    //   File? file = await body["video"].file;
    //   MultipartFile multipartFile = MultipartFile(file, filename: "video");
    //   b["video"] = multipartFile;
    //   body.remove("video");
    // }

    // final keysToRemove = <String>[];
    // for (var entry in body.entries) {
    //   final key = entry.key;
    //   if (key.startsWith('files[') && entry.value is AssetEntity) {
    //     final asset = entry.value as AssetEntity;
    //     File? file = await asset.file;
    //     if (file != null) {
    //       b[key] = MultipartFile(
    //         file,
    //         filename: 'gallery_${key.split('[')[1].split(']')[0]}.jpg',
    //       );
    //     }
    //     keysToRemove.add(key);
    //   }
    // }

    if (body["document"] != null && body["document"] is AssetEntity) {
      File? file = await body["document"].file;
      MultipartFile multipartFile = MultipartFile(file, filename: "document");
      b["document"] = multipartFile;
      body.remove("document");
    }

    body.forEach((key, value) {
      b[key] = value;
    });

    return networkHandler.postRequest(
      endpoint: "sign-up",
      create: () => APIResponse<User>(create: () => User()),
      body: FormData(b),
    );
  }

  Future<LoadingState<User?>> updateProfile(Map<String, dynamic> body) async {
    Map<String, dynamic> b = {};
    if (body["image"] != null && body["image"] is AssetEntity) {
      File? file = await (body["image"] as AssetEntity).file;
      MultipartFile multipartFile = MultipartFile(
        file,
        filename: basename(file?.path ?? ""),
      );
      b["image"] = multipartFile;
      body.remove("image");
    }
    if (body["cover"] != null && body["cover"] is AssetEntity) {
      File? file = await body["cover"].file;
      MultipartFile multipartFile = MultipartFile(
        file,
        filename: basename(file?.path ?? ""),
      );
      b["cover"] = multipartFile;
      body.remove("cover");
    }
    if (body["document"] != null && body["document"] is AssetEntity) {
      File? file = await body["document"].file;
      MultipartFile multipartFile = MultipartFile(
        file,
        filename: basename(file?.path ?? ""),
      );
      b["document"] = multipartFile;
      body.remove("document");
    }
    body["_method"] = 'PUT';

    body.forEach((key, value) {
      b[key] = value;
    });

    return networkHandler.postRequest(
      endpoint: "update-profile",
      create: () => APIResponse<User>(create: () => User()),
      body: FormData(b),
    );
  }

  Future<LoadingState<User?>> getProfile() async {
    return networkHandler.getRequest(
      endpoint: "profile",
      create: () => APIResponse<User>(create: () => User()),
    );
  }

  Future<LoadingState> changePassword(Map<String, String> body) async {
    return networkHandler.postRequest(
      endpoint: "update-passward?_method=PATCH",
      create: () => APIDynamicResponse(create: () => DynamicModel()),
      body: body,
    );
  }

  Future<LoadingState> forgetPassword(String email) async {
    return networkHandler.postRequest(
      endpoint: "forget-password-send-code",
      create: () => APIDynamicResponse(create: () => DynamicModel()),
      body: {"email": email},
    );
  }

  Future<LoadingState> forgetPasswordByMobile(
    String phoneCode,
    String phone,
  ) async {
    print("phoneCode: $phoneCode, phone: $phone");
    return networkHandler.postRequest(
      endpoint: "forget-password-send-code",
      create: () => APIDynamicResponse(create: () => DynamicModel()),
      body: {"country_code": phoneCode, "phone": phone},
    );
  }

  Future<LoadingState> resetPasswordByMobile(
    String phoneCode,
    String phone,
    String code,
    String password,
  ) async {
    return networkHandler.postRequest(
      endpoint: "reset-password",
      create: () => APIDynamicResponse(create: () => DynamicModel()),
      body: {
        "country_code": phoneCode,
        "phone": phone,
        "code": code,
        "password": password,
      },
    );
  }

  Future<LoadingState> resetPasswordByEmail(
    String email,
    String code,
    String password,
  ) async {
    return networkHandler.postRequest(
      endpoint: "reset-password",
      create: () => APIDynamicResponse(create: () => DynamicModel()),
      body: {
        "email": email,
        "code": code,
        "password": password,
        "password_confirmation": password,
      },
    );
  }

  Future<LoadingState> resendCode({
    String phoneCode = "965",
    String? phone,
    String? email,
  }) async {
    return networkHandler.getRequest(
      endpoint: "resend-code",
      create: () => APIDynamicResponse(create: () => DynamicModel()),
      query:
          email != null
              ? {"email": email}
              : {"country_code": phoneCode, "phone": phone},
    );
  }

  Future<LoadingState<User?>> verifyCode({
    String phoneCode = "965",
    String? phone,
    String? code,
  }) async {
    return networkHandler.postRequest(
      endpoint: "auth/verified",
      create: () => APIResponse<User>(create: () => User()),
      body: {"calling_code": phoneCode, "mobile": phone, "code": code},
    );
  }

  Future<LoadingState<User?>> active({
    String phoneCode = "965",
    String? phone,
    String? email,
    String? code,
  }) async {
    print("code: $code");
    return networkHandler.postRequest(
      endpoint: "activate",
      create: () => APIResponse<User>(create: () => User()),
      body: {
        "country_code": phoneCode,
        "phone": phone,
        "email": email,
        "code": code,
        "device_type": Platform.isAndroid ? "android" : "ios",
        "device_id": Platform.isAndroid ? "android" : "ios",
        "_method": "patch",
      },
    );
  }

  Future<LoadingState> sendFcmToken(String fcmToken) async {
    int? userId = Get.find<PreferenceManager>().getUser?.id?.toInt();
    return networkHandler.postRequest(
      endpoint: "update-devices",
      create: () => APIDynamicResponse(create: () => DynamicModel()),
      body: {
        "device_id": fcmToken,
        if (userId != null) "user_id": userId,
        "lang": Get.find<PreferenceManager>().getLocale,
        "device_type": Platform.isAndroid ? "android" : "ios",
      },
    );
  }

  Future<LoadingState> removeAccount() async {
    print(
      "Removing account for user: ${Get.find<PreferenceManager>().getUser?.id}",
    );
    return networkHandler.deleteRequest(
      endpoint: "delete-account",
      create: () => APIDynamicResponse(create: () => DynamicModel()),
    );
  }

  Future<LoadingState<Wallet>> getWallet() async {
    return networkHandler.getRequest(
      endpoint: "user/wallet",
      create: () => APIResponse<Wallet>(create: () => Wallet()),
    );
  }

  Future<LoadingState> refundWallet(String amount) async {
    return networkHandler.postRequest(
      endpoint: "user/wallet/refund",
      body: {"amount": amount},
      create: () => APIDynamicResponse(create: () => DynamicModel()),
    );
  }
}
