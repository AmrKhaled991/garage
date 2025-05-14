import 'dart:async';
import 'package:garage/core/ui/LoadingWidget.dart';
import 'package:garage/core/ui/MyLoadingButton.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/routes/arguments.dart';
import 'package:garage/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import 'otp_verify_controller.dart';

class OtpVerifyPage extends StatefulWidget {
  String? phone;
  String? phoneCode;

  OtpVerifyPage({super.key}) {
    phoneCode = Get.arguments[MyArguments.PHONE_CODE] ?? "";
    phone = Get.arguments[MyArguments.PHONE] ?? "";
  }

  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  final controller = Get.find<OtpVerifyController>();

  TextEditingController codeController = TextEditingController();
  StreamController<ErrorAnimationType> codeErrorController =
      StreamController<ErrorAnimationType>();

  @override
  void initState() {
    if (controller.enableResend.value) {
      controller.resendCode();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text(
              "enter_4_code".tr,
              textAlign: TextAlign.start,
              style: MyTextStyle.myBlackBoldLargeTitle.copyWith(fontSize: 24),
            ),
            Text(
              "code_has_been_sent".tr,
              textAlign: TextAlign.start,
              style: MyTextStyle.myGreySubTitle.copyWith(),
            ),
            Text(
              widget.phoneCode! + widget.phone!,
              textAlign: TextAlign.start,
              style: MyTextStyle.myGreySubTitle.copyWith(),
            ),

            const SizedBox(height: 20),
            Directionality(
              textDirection: TextDirection.ltr,
              child: PinCodeTextField(
                textStyle: MyTextStyle.myPrimaryBoldLargeTitle,
                length: 4,
                obscureText: false,
                animationType: AnimationType.scale,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 56,
                  fieldWidth: 56,
                  activeFillColor: colorContainer,
                  activeColor: Colors.grey,
                  inactiveColor: Colors.transparent,
                  inactiveFillColor: colorContainer,
                  selectedColor: colorPrimary,
                  selectedFillColor: colorContainer,
                ),
                keyboardType: TextInputType.number,
                autoDismissKeyboard: true,
                autoDisposeControllers: true,
                showCursor: false,
                animationDuration: const Duration(milliseconds: 300),
                // backgroundColor: Theme.of(context).primaryColor,
                enableActiveFill: true,
                errorAnimationController: codeErrorController,
                controller: codeController,
                appContext: context,
                onChanged: (String value) {},
              ),
            ),

            Obx(() {
              return LoadingWidget(
                loadingState: controller.resendLoading.value,
                loadingOnly: true,
                child: Obx(() {
                  return TextButton(
                    onPressed: () {
                      if (controller.enableResend.value) {
                        controller.resendCode();
                      }
                    },
                    child: Text(
                      "resend_code".tr,
                      style: MyTextStyle.myWhiteBoldLargeTitle.copyWith(),
                    ),
                  );
                }),
              );
            }),
            Obx(() {
              return Visibility(
                visible: controller.enableResend.value == false,
                child: Obx(() {
                  return Row(
                    children: [
                      Text(
                        "resend_code_after".tr,
                        style: MyTextStyle.myBlackTitle.copyWith(
                          color: colorPrimary,
                        ),
                      ),
                      Text(
                        "(${controller.timerCount.value})",
                        style: MyTextStyle.myBlackTitle.copyWith(
                          color: colorPrimary,
                        ),
                      ),
                    ],
                  );
                }),
              );
            }),
            const Spacer(),
            MyLoadingButton(
              title: "continue".tr,
              onClick: (RoundedLoadingButtonController _controller) {
                if (codeController.text.toString().isEmpty) {
                  Get.toNamed(
                    Routes.RESET_PASSWORD_BY_MOBILE,
                    arguments: [widget.phone, widget.phoneCode],
                  );
                  _controller.error();
                  Timer(const Duration(seconds: 1), () {
                    _controller.reset();
                  });
                  return;
                }

                controller.active(codeController.text.toString(), (success) {
                  if (success) {
                    _controller.success();
                    Get.offAllNamed(Routes.MAIN);
                  } else {
                    _controller.error();
                    Get.toNamed(
                      Routes.RESET_PASSWORD_BY_MOBILE,
                      arguments: [widget.phone, widget.phoneCode],
                    );
                  }
                  Timer(const Duration(seconds: 1), () {
                    _controller.reset();
                  });
                });
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
