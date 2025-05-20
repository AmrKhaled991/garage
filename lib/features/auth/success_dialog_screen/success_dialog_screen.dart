import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:garage/core/ui/MyButton.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';

class SuccessDialogScreen extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? buttonText;
  final Function? onTap;
  const SuccessDialogScreen({
    super.key,
    this.title,
    this.subtitle,
    this.buttonText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            decoration: MyshapesStyle.PrimaryDecoration,
            child: IntrinsicHeight(
              child: Column(
                children: [
                  const MyImage(
                    image: "assets/images/ic_check.svg",
                    width: 100,
                    height: 100,
                  ),
                  Text(
                    title?.tr ?? "success".tr,
                    textAlign: TextAlign.start,
                    style: MyTextStyle.myBlackBoldLargeTitle.copyWith(
                      fontSize: 24,
                      color: colorPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    subtitle?.tr ?? "success_done".tr,
                    textAlign: TextAlign.center,
                    style: MyTextStyle.myBlackBoldLargeTitle.copyWith(),
                  ),
                  const SizedBox(height: 16),
                  MyButton(
                    title: buttonText?.tr ?? "home".tr,
                    onClick: () {
                      Get.offAllNamed(Routes.MAIN);

                      onTap?.call();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
