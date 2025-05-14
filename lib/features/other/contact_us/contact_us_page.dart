import 'dart:async';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/ui/MyLoadingButton.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/core/ui/widgets/my_text_form.dart';
import 'package:garage/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:garage/utils/utlis.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'contact_us_controller.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final controller = Get.find<ContactUsController>();
  final state = Get.find<ContactUsController>().state;
  UserController userController = Get.find();

  @override
  void initState() {
    if (userController.isLogged.value) {
      state.nameController.text = userController.user.value?.name ?? "";
      state.phoneController.text = userController.user.value?.phone ?? "";
      state.emailController.text = userController.user.value?.email ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "contact_us".tr,
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          MyTextForm(
            controller: state.nameController,
            hint: "name".tr,
            textInputType: TextInputType.text,
          ),
          const SizedBox(
            height: 16,
          ),
          MyTextForm(
            controller: state.phoneController,
            hint: "phone_number".tr,
            textInputType: TextInputType.phone,
          ),
          const SizedBox(
            height: 16,
          ),
          MyTextForm(
            controller: state.emailController,
            hint: "email".tr,
            textInputType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 16,
          ),
          MyTextForm(
            controller: state.messageController,
            hint: "message".tr,
            textInputType: TextInputType.text,
            lines: 5,
          ),
          Obx(() => Visibility(
              visible: state.contactUsLoading.value.error,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  state.contactUsLoading.value.message,
                  textAlign: TextAlign.center,
                  style: MyTextStyle.myErrorSubTitle,
                ),
              ))),
          const SizedBox(
            height: 30,
          ),
          MyLoadingButton(
              title: "send".tr,
              onClick: (RoundedLoadingButtonController _controller) {
                if (!controller.validation()) {
                  _controller.error();
                  Timer(const Duration(seconds: 1), () {
                    _controller.reset();
                  });
                  return;
                }

                controller.contactUs({
                  "user_name": state.nameController.text,
                  "phone": state.phoneController.text,
                  "complaint": state.messageController.text,
                  "email": state.emailController.text,
                  "type": "contact",
                }, (success) {
                  if (success) {
                    Utils.showSnackBar("message_sent".tr);
                    _controller.success();
                  } else {
                    _controller.error();
                  }

                  Timer(const Duration(seconds: 1), () {
                    _controller.reset();
                  });
                });
              }),
        ],
      ),
    );
  }
}
