import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/ui/custom_rich_text.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/widgets/custom_country_code_and_flag.dart';
import 'package:garage/core/ui/widgets/my_text_form.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/routes/arguments.dart';
import 'package:garage/utils/utlis.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import '../../../core/ui/MyLoadingButton.dart';
import '../../../core/ui/my_scaffold.dart';
import '../../../theme/styles.dart';
import 'forget_password_controller.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();
    final controller = Get.find<ForgetPasswordController>();
    final state = Get.find<ForgetPasswordController>().state;
    return MyScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "forgot_password".tr,
            textAlign: TextAlign.start,
            style: MyTextStyle.myBlackBoldLargeTitle.copyWith(fontSize: 24),
          ),
          Text(
            "forget_password_hint_dont_worry".tr,
            textAlign: TextAlign.start,
            style: MyTextStyle.myGreySubTitle.copyWith(),
          ),
          const SizedBox(height: 16),
          MyTextForm(
            hasIconConstraints: false,
            hint: "phone_number".tr,
            controller: state.phoneNumber,
            textInputType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          Obx(
            () => Center(
              child: Visibility(
                visible: userController.forgetPasswordLoading.value.error,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    userController.forgetPasswordLoading.value.message,
                    textAlign: TextAlign.center,
                    style: MyTextStyle.myErrorSubTitle,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),

          MyLoadingButton(
            title: "send_code".tr,
            onClick: (RoundedLoadingButtonController _controller) {
              Get.toNamed(Routes.OTP_VERIFY ,arguments: {MyArguments.PHONE: "01557043883", MyArguments.PHONE_CODE: "966"});
              if (!controller.validations()) {
                _controller.error();
                Timer(const Duration(seconds: 1), () {
                  _controller.reset();
                });
                return;
              }

              userController.forgetPassword(state.phoneNumber.text, (success) {
                if (success) {
                  _controller.success();
                  Get.toNamed(
                    Routes.RESET_PASSWORD_BY_MOBILE,
                    arguments: {MyArguments.PHONE: state.phoneNumber.text},
                  );
                  Utils.showSnackBar(
                    userController.forgetPasswordLoading.value.data?.message ??
                        "Code Sent",
                  );
                } else {
                  _controller.error();
                  Utils.showSnackBar(
                    userController.forgetPasswordLoading.value.message,
                  );
                }
                Timer(const Duration(seconds: 1), () {
                  _controller.reset();
                });
              });
            },
          ),
          const SizedBox(height: 30),
        ],
      ).paddingAll(16),
    );
  }
}
