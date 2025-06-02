import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/user.dart';
import 'package:garage/core/repositories/auth_repository.dart';
import 'package:garage/routes/arguments.dart';
import 'package:get/get.dart';
import 'package:garage/utils/utlis.dart';

class OtpVerifyController extends GetxController {
  // final OtpVerifyState state = OtpVerifyState();
  AuthRepository authRepository = Get.find();
  UserController userController = Get.find();

  var resendLoading = Rx<LoadingState>(LoadingState.success(true));
  var verifyLoading = LoadingState<User?>().obs;
  var enableResend = true.obs;
  var timerCount = 60.obs;

  void resendCode() async {
    resendLoading.value = LoadingState.loading();
    resendLoading.value = await authRepository.resendCode(
      // email: Get.arguments[MyArguments.EMAIL]??"",
      phoneCode: Get.arguments[MyArguments.PHONE_CODE] ?? "",
      phone: Get.arguments[MyArguments.PHONE] ?? "",
    );
    if (resendLoading.value.success) {
      Utils.showSnackBar("code_number_hint".tr);
      enableResend.value = false;
      countDownTimer();
    } else {
      Utils.showSnackBar(resendLoading.value.message);
      enableResend.value = true;
    }
  }

  countDownTimer() async {
    timerCount.value = 60;
    for (int x = 60; x > 0; x--) {
      await Future.delayed(const Duration(seconds: 1)).then((_) {
        timerCount.value -= 1;
      });
    }
    enableResend.value = true;
  }

  void verifyCode(String code, Function(bool) onFinish) async {
    verifyLoading.value = LoadingState.loading();
    verifyLoading.value = await authRepository.active(
      phone: Get.arguments[MyArguments.PHONE] ?? "",
      phoneCode: Get.arguments[MyArguments.PHONE_CODE] ?? "",
      email: Get.arguments[MyArguments.EMAIL] ?? "",
      code: code,
    );
    onFinish.call(verifyLoading.value.success);
    if (verifyLoading.value.success) {
      userController.setLoggedUser(verifyLoading.value.data);
    } else {
      Utils.showSnackBar(verifyLoading.value.message);
    }
  }
}
