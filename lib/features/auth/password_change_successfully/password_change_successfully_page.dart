import 'package:flutter/widgets.dart';
import 'package:garage/core/ui/MyLoadingButton.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class PasswordChangeSuccessfullyPage extends StatelessWidget {
  const PasswordChangeSuccessfullyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SuccessCard();
  }
}

class SuccessCard extends StatelessWidget {
  const SuccessCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          decoration: ShapeDecoration(
            color: const Color(0xFF242424),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: IntrinsicHeight(
            child: Column(
              children: [
                const MyImage(
                  image: "assets/images/ic_check.svg",
                  width: 100,
                  height: 100,
                ),
                Text(
                  "password_changed_2".tr,
                  textAlign: TextAlign.start,
                  style: MyTextStyle.myBlackBoldLargeTitle.copyWith(
                    fontSize: 24,
                    color: colorPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "password_changed_successfully".tr,
                  textAlign: TextAlign.center,
                  style: MyTextStyle.myBlackBoldLargeTitle.copyWith(),
                ),
                const SizedBox(height: 16),
                MyLoadingButton(
                  title: "back_to_login".tr,
                  onClick: (RoundedLoadingButtonController _controller) {
                    Get.offAllNamed(Routes.LOGIN);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
