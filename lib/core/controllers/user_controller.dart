
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:garage/core/controllers/address_controller.dart';
import 'package:garage/core/controllers/cart_controller.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/city.dart';
import 'package:garage/core/repositories/auth_repository.dart';
import 'package:garage/core/repositories/favorite_repository.dart';
import 'package:garage/core/storage/preference_manager.dart';
import 'package:get/get.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/routes/arguments.dart';
import 'package:garage/utils/utlis.dart';
import '../networking/models/user.dart';


class UserController extends GetxController{

  final PreferenceManager preferenceManager = Get.find();
  final AuthRepository authRepository = Get.find();
  final FavoriteRepository favoriteRepository = Get.find();
  late AddressController addressController;
  late CartController cartController;

  @override
  void onReady() async{
    userToken = await getUserUniqueKey();
    cartController = Get.find();
    addressController = Get.find();

    user.listen((user) async{
      if(user!=null) {
        isLogged.value = true;
        preferenceManager.setUser(user);
        userToken = user.id.toString();
        print("user logged: ${user.id}");
      }else{
        isLogged.value = false;
        preferenceManager.setUser(null);
        userToken = await getUserUniqueKey();
        // addressController.selectedArea.value = preferenceManager.getLastSelectedArea;
        // addressController.addresses.value = LoadingState.errorNoRetry();
      }
      // cartController.getCartItems(false);
    });

    user.value = preferenceManager.getUser;

    selectedArea.listen((area) async{
      preferenceManager.setLastSelectedArea(area);
    });

    if(user.value != null) {
      fetchProfile();
    }

    //send fcm token
    print("FCM token: ${preferenceManager.getFcmToken}");
    sendFcmToken(preferenceManager.getFcmToken??"");

    selectedArea.value = preferenceManager.getLastSelectedArea;

    super.onReady();
  }


  @override
  void onInit() {
    super.onInit();

  }

  var isLogged = false.obs;
  var user = Rx<User?>(null);
  var login = LoadingState<User?>().obs;
  var updateUser = LoadingState<User?>().obs;
  var changePassword = LoadingState().obs;
  var forgetPasswordLoading = LoadingState().obs;

  String? userToken;

  var selectedGender = Rx<String?>("male");
  var selectedBirthDay = Rx<String?>(null);

  var selectedArea = Rx<StateData?>(null);

  void loginUser({bool withPhone = false,String? emailOrPhone, String? password, String? phoneCode, Function(bool)? onFinish}) async{
    login.value = LoadingState.loading();
    Map<String,String> data = withPhone?{"country_code":phoneCode??"","phone":emailOrPhone??"","password":password??""}
        : {"email":emailOrPhone??"","password":password??""};
    login.value = await authRepository.login(data,withPhone: withPhone);
    if(login.value.success){
      if(login.value.key == "needActive"){
        Get.toNamed(Routes.OTP_VERIFY, arguments: {
          MyArguments.PHONE_CODE: login.value.data?.countryCode,
          MyArguments.PHONE: login.value.data?.phone,
          MyArguments.EMAIL: login.value.data?.email,
        });
      }else {
        setLoggedUser(login.value.data);
        Get.offAllNamed(Routes.MAIN);
      }
    }else{
      Utils.showSnackBar(login.value.message);
    }
    onFinish?.call(login.value.success);
  }

  logout() async{
    user.value = null;
    sendFcmToken(preferenceManager.getFcmToken??"");
    preferenceManager.logout();
    // await FirebaseAuth.instance.signOut();
  }

  void register(Map<String, dynamic> data, Function(bool) onFinish) async{
    login.value = LoadingState.loading();
    login.value = await authRepository.register(data);

    if(login.value.success){
      if(login.value.key == "needActive"){
        Get.toNamed(Routes.OTP_VERIFY, arguments: {
          MyArguments.PHONE_CODE: login.value.data?.countryCode,
          MyArguments.PHONE: login.value.data?.phone,
          MyArguments.EMAIL: login.value.data?.email,
        });
      }else {
        setLoggedUser(login.value.data);
        Get.offAllNamed(Routes.MAIN);
      }
    }else{
      Utils.showSnackBar(login.value.message);
    }
    onFinish.call(login.value.success);
  }

  void fetchProfile({Function(bool)? onFinish}) async{
    var response = await authRepository.getProfile();

    if(response.success){
      user.value = response.data;
      // if(user.value?.isVerified == false){
      //   Future.delayed(Duration(seconds: 3),(){
      //     Get.toNamed(Routes.OTP_VERIFY,
      //     arguments: {
      //       MyArguments.PHONE: user.value?.phone,
      //       MyArguments.PHONE_CODE: user.value?.countryCode,
      //       MyArguments.INIT_SEND_CODE: true
      //     });
      //   });
      // }
    }
    onFinish?.call(response.success);
  }

  void resetPassword(Map<String, String> data, Function(bool) onSuccess) async{
    changePassword.value = LoadingState.loading();
    changePassword.value = await authRepository.changePassword(data);
    onSuccess.call(changePassword.value.success);
  }

  void forgetPassword(String phone, Function(bool) onFinish) async{
    forgetPasswordLoading.value = LoadingState.loading();
    forgetPasswordLoading.value = await authRepository.forgetPassword(phone);
    onFinish.call(forgetPasswordLoading.value.success);
  }

  void forgetPasswordByMobile(String phoneCode, String phone, Function(bool) onFinish) async{
    forgetPasswordLoading.value = LoadingState.loading();
    forgetPasswordLoading.value = await authRepository.forgetPasswordByMobile(phoneCode,phone);
    onFinish.call(forgetPasswordLoading.value.success);
  }


  void resetPasswordByMobile(String phoneCode,String phone,String code,String password, Function(bool) onFinish) async{
    forgetPasswordLoading.value = LoadingState.loading();
    forgetPasswordLoading.value = await authRepository.resetPasswordByMobile(phoneCode,phone,code,password);
    onFinish.call(forgetPasswordLoading.value.success);
    Utils.showSnackBar(forgetPasswordLoading.value.message);
  }

  void resetPasswordByEmail(String email,String code,String password, Function(bool) onFinish) async{
    forgetPasswordLoading.value = LoadingState.loading();
    forgetPasswordLoading.value = await authRepository.resetPasswordByEmail(email,code,password);
    onFinish.call(forgetPasswordLoading.value.success);
    Utils.showSnackBar(forgetPasswordLoading.value.message);
  }


  void updateProfile(Map<String, dynamic> data, Function(bool) onFinish) async{
    updateUser.value = LoadingState.loading();
    updateUser.value = await authRepository.updateProfile(data);
    if(updateUser.value.success){
      user.value = updateUser.value.data;
      Utils.showSnackBar("success_profile_update".tr);
    }else{
      Utils.showSnackBar(updateUser.value.message);
    }
    onFinish.call(updateUser.value.success);
  }

  void sendFcmToken(String token) {
    preferenceManager.saveFCMToken(token);
    authRepository.sendFcmToken(token);
  }

  Future<String> getUserUniqueKey() async{
    var USER_TOKEN = "simulator";
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo deviceData = await deviceInfoPlugin.androidInfo;
      USER_TOKEN = "${deviceData.id}_${deviceData.brand}";
    } else if (Platform.isIOS) {
      try{
        IosDeviceInfo deviceData = await deviceInfoPlugin.iosInfo;
        USER_TOKEN = "${deviceData.model}_${deviceData.identifierForVendor}";
      } on PlatformException {
        USER_TOKEN = "ios_simulator";
      }
    }
    return USER_TOKEN;
  }


  void removeAccount({Function? success}) async{
    var response = await authRepository.removeAccount();
    if(response.success){
      logout();
      success?.call();
    }
  }

  void setLoggedUser(User? loggedUser) {
    user.value = loggedUser;
    preferenceManager.setAccessToken(loggedUser?.token??"");
    sendFcmToken(preferenceManager.getFcmToken??"");
    Utils.showSnackBar("login_success".tr,);
  }

}
