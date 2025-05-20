import 'package:flutter/material.dart';
import 'package:garage/core/controllers/main_controller.dart';
import 'package:garage/core/storage/preference_manager.dart';
import 'package:garage/core/ui/MyButton.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Get.find<PreferenceManager>();
    final change = Get.find<MainController>();
    final isAr = locale.getLocale == 'ar';
    return MyScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (isAr) {
                  change.changeLanguage('en');
                } else {
                  change.changeLanguage('ar');
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 5,
                children: [
                  Text(
                    isAr ? 'العربية' : 'English',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Zain',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Icon(Icons.language, color: Colors.white, size: 24),
                ],
              ),
            ),
            const Spacer(),
            const MyImage(
              image: "assets/images/logo.png",
              width: 234.14,
              height: 234.14,
            ),
            const SizedBox(height: 30),
            Text(
              "welcome_in_app".tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Zain',
                fontWeight: FontWeight.w800,
                height: 1.20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "service_welcom_hint".tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFCCCAC7),
                fontSize: 18,
                fontFamily: 'Zain',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
            const Spacer(),
            MyButton(
              child: Text(
                "start_now_hint".tr,
                style: const TextStyle(
                  color: Color(0xFF201F1D),
                  fontSize: 18,
                  fontFamily: 'Zain',
                  fontWeight: FontWeight.w700,
                  height: 1.50,
                ),
              ),
              onClick: () {
                Get.toNamed(Routes.INTRO);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
