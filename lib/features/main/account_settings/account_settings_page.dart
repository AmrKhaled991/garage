import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/core/controllers/main_controller.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/core/ui/sheet/normal_sheet.dart';
import 'package:garage/features/auth/profile/widgets/auth_item.dart';
import 'package:garage/features/auth/profile/widgets/custom_exist_sheet.dart';
import 'package:garage/features/auth/profile/widgets/settings_item.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:garage/utils/utlis.dart';
import 'package:get/get.dart';

import 'account_settings_controller.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find();
    final AccountSettingsController logic = Get.put(
      AccountSettingsController(),
    );

    return MyScaffold(
      title: "account_settings".tr,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 8,
          children: [
            SettingsItem(
              
              title: "change_password".tr,
              icon: "assets/images/ic_change_password.svg",
              iconColor: Colors.white,
              
              onClick: () => Get.toNamed(Routes.CHANGE_PASSWORD),
            ),
            languageWidget(context, mainController),
            GestureDetector(
              onTap: () {
                Utils.showSheet(
                  height: 250,
                  context,
                  NormalSheet(
                    child: CustomExistSheet(
                      title: "remove_account".tr,
                      onClick: () => Get.back(),
                    ),
                  ),
                );
              },

              child: Container(
                width: Get.width,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: MyshapesStyle.PrimaryDecoration,
                child: Center(
                  child: Text(
                    "remove_account".tr,
                    style: const TextStyle(
                      color: Color(0xFFFF4C4C),
                      fontSize: 18,
                      fontFamily: 'Zain',
                      fontWeight: FontWeight.w700,
                      height: 1.50,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget languageWidget(BuildContext context, MainController mainController) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: MyshapesStyle.PrimaryDecoration,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(6),
            ),
            child: const MyImage(image: "assets/images/ic_lang.svg", width: 25),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "language".tr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Zain',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Obx(
                () => Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  decoration: const ShapeDecoration(
                    shape: StadiumBorder(),
                    color: colorBabyBlue,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    shape: const StadiumBorder(),
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            mainController.toggleLanguage();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: ShapeDecoration(
                              shape: const StadiumBorder(),
                              color:
                                  (mainController.language.value == "en")
                                      ? colorPrimary
                                      : null,
                            ),
                            child: Text(
                              "English",
                              style: MyTextStyle.myBlackSubTitle.copyWith(
                                color:
                                    (mainController.language.value == "en")
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            mainController.toggleLanguage();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: ShapeDecoration(
                              shape: const StadiumBorder(),
                              color:
                                  (mainController.language.value == "ar")
                                      ? colorPrimary
                                      : null,
                            ),
                            child: Text(
                              "العربيه",
                              style: MyTextStyle.myBlackSubTitle.copyWith(
                                color:
                                    (mainController.language.value == "ar")
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
