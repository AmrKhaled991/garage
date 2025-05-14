import 'dart:async';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/ui/MyLoadingButton.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/core/ui/widgets/my_text_form.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/utils/utlis.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'change_password_controller.dart';

class ChangePasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChangePasswordController>();
    final state = Get.find<ChangePasswordController>().state;
    UserController userController = Get.find();

    return MyScaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          MyTextForm(
            controller: state.oldPassword,
            hint: "current_password".tr,
            isPassword: true,
            textInputType: TextInputType.text,
          ),
          const SizedBox(
            height: 16,
          ),
          MyTextForm(
            controller: state.password,
            hint: "password".tr,
            isPassword: true,
            textInputType: TextInputType.text,
          ),
          const SizedBox(
            height: 16,
          ),
          MyTextForm(
            controller: state.passwordConfirm,
            hint: "password_confirm".tr,
            isPassword: true,
            textInputType: TextInputType.text,
          ),
          const SizedBox(
            height: 32,
          ),
          MyLoadingButton(
            title: "confirm".tr,
            onClick: (RoundedLoadingButtonController _controller) {
              if (!controller.validations()) {
                _controller.error();
                Timer(const Duration(seconds: 1), () {
                  _controller.reset();
                });
                return;
              }

              userController.resetPassword({
                "current_password": state.oldPassword.text,
                "password": state.password.text,
                "password_confirmation": state.passwordConfirm.text,
              },
                      (success) async{
                    if (success) {
                      _controller.success();
                      Get.offAllNamed(Routes.MAIN);
                    } else {
                      _controller.error();
                      Utils.showSnackBar( userController.changePassword.value.message);
                    }
                    Timer(const Duration(seconds: 1), () {
                      _controller.reset();
                    });
                  }
              );
            },
          ),
        ],
      ), 
    );
  }
}
