import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/ui/MyLoadingButton.dart';
import 'package:garage/core/ui/custom_rich_text.dart';
import 'package:garage/core/ui/widgets/my_text_form.dart';
import 'package:garage/features/auth/login/login_controller.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class loginFormSection extends StatelessWidget {
  loginFormSection({super.key});
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    final state = Get.find<LoginController>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MyTextForm(
          hasIconConstraints: false,
          hint: "phone_number".tr,
          controller: state.phoneOrEmail.value,
          textInputType: TextInputType.phone,
        ),
        const SizedBox(height: 16),
        MyTextForm(
          hint: "password".tr,
          isPassword: true,
          controller: state.password.value,
          textInputType: TextInputType.text,
        ),
        const SizedBox(height: 16),
        InkWell(
          child: Text(
            "forget_password".tr,
            style: MyTextStyle.mySecondarySubTitle,
          ),

          onTap: () {
            Get.toNamed(Routes.FORGET_PASSWORD);
          },
        ),
        SizedBox(height: Get.height * 0.1),
        Obx(() {
          return IgnorePointer(
            ignoring: !controller.isReady,
            child: MyLoadingButton(
              title: "login".tr,
              color: controller.isReady ? colorPrimary : colorSecondary,
              onClick: (RoundedLoadingButtonController _controller) {
                if (!controller.validations()) {
                  _controller.error();
                  Timer(const Duration(seconds: 1), () {
                    _controller.reset();
                  });
                  return;
                }
                userController.loginUser(
                  withPhone: true,
                  phoneCode: "965",
                  emailOrPhone: state.phoneOrEmail.value.text,
                  password: state.password.value.text,
                  onFinish: (success) async {
                    if (success) {
                      _controller.success();
                    } else {
                      _controller.error();
                    }
                    Timer(const Duration(seconds: 1), () {
                      _controller.reset();
                    });
                  },
                );
              },
            ),
          );
        }),
        const SizedBox(height: 25),
        Center(
          child: CustomRichText(
            text: "dont_have_account",
            tapText: "create_account",
            onTap: () {
              Get.toNamed(Routes.SIGN_UP);
            },
          ),
        ),
      ],
    );
  }
}
