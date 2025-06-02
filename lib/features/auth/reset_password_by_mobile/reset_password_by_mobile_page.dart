import 'dart:async';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/ui/MyLoadingButton.dart';
import 'package:garage/core/ui/widgets/my_text_form.dart';
import 'package:garage/features/auth/success_dialog_screen/success_dialog_screen.dart';
import 'package:garage/routes/arguments.dart';
import 'package:garage/theme/styles.dart';
import 'package:garage/utils/utlis.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import '../../../core/ui/my_scaffold.dart';
import '../../../routes/app_pages.dart';
import 'reset_password_by_mobile_controller.dart';

class ResetPasswordByMobilePage extends StatelessWidget {
  final controller = Get.find<ResetPasswordByMobileController>();
  final state = Get.find<ResetPasswordByMobileController>().state;
  UserController userController = Get.find();

  ResetPasswordByMobilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "reset_password".tr,
              textAlign: TextAlign.start,
              style: MyTextStyle.myBlackBoldLargeTitle.copyWith(fontSize: 24),
            ),
            Text(
              "enter_new_and_confirm_password".tr,
              textAlign: TextAlign.start,
              style: MyTextStyle.myGreySubTitle.copyWith(),
            ),
            MyTextForm(
              controller: state.code,
              hint: "code".tr,
              textInputType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            MyTextForm(
              controller: state.password,
              hint: "password".tr,
              isPassword: true,
              textInputType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            MyTextForm(
              controller: state.passwordConfirm,
              hint: "password_confirm".tr,
              isPassword: true,
              textInputType: TextInputType.text,
            ),
            const Spacer(),
            MyLoadingButton(
              title: "save".tr,
              onClick: (RoundedLoadingButtonController _controller) {
                if (!controller.validations()) {
                  _controller.error();
                  Timer(const Duration(seconds: 1), () {
                    _controller.reset();
                  });
                  return;
                }

                userController.resetPasswordByMobile(
                  /*Get.arguments!=null? Get.arguments[MyArguments.PHONE_CODE]:*/ "965",
                  Get.arguments != null ? Get.arguments[MyArguments.PHONE] : "",
                  state.code.text,
                  state.password.text,
                  (success) async {
                    if (success) {
                      _controller.success();
                      showDialog(
                        context: context,
                        builder:
                            (_) => AlertDialog(
                              contentPadding: const EdgeInsets.all(0),
                              content: SuccessDialogScreen(
                                title: "password_changed".tr,
                                subtitle: "password_changed_successfully".tr,
                                buttonText: "login".tr,
                                onTap: () => Get.offAllNamed(Routes.LOGIN),
                              ),
                            ),
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
                  },
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
