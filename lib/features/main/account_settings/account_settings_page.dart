import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/core/controllers/main_controller.dart';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/core/ui/sheet/normal_sheet.dart';
import 'package:garage/features/auth/profile/widgets/auth_item.dart';
import 'package:garage/features/auth/profile/widgets/custom_exist_sheet.dart';
import 'package:garage/features/auth/profile/widgets/settings_item.dart';
import 'package:garage/features/main/account_settings/widgest/language_widget.dart';
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
    UserController userController = Get.find();
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
            LanguageWidget(),
            GestureDetector(
              onTap: () {
                Utils.showSheet(
                  context,
                  NormalSheet(
                    child: CustomExistSheet(
                      title: "remove_account".tr,
                      onClick:
                          () => showDialog(
                            context: context,
                            builder:
                                (BuildContext context) => CupertinoAlertDialog(
                                  title: Text("remove_account".tr),
                                  content: Text("remove_account_msg".tr),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      isDestructiveAction: true,
                                      child: Text("yes".tr),
                                      onPressed: () {
                                        userController.removeAccount();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      isDefaultAction: true,
                                      child: Text("no".tr),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                          ),
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
}
