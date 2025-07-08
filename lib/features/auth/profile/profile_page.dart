// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage/features/auth/profile/widgets/auth_item.dart';
import 'package:garage/features/main/account_settings/account_settings_page.dart';
import 'package:garage/features/main/account_settings/widgest/language_widget.dart';
import 'package:garage/utils/links_utils.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:garage/core/controllers/main_controller.dart';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/core/ui/sheet/normal_sheet.dart';
import 'package:garage/features/auth/profile/widgets/custom_exist_sheet.dart';
import 'package:garage/features/auth/profile/widgets/settings_item.dart';
import 'package:garage/features/main/common/text_header_widget.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/utlis.dart';
import 'profile_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final controller = Get.find<ProfileController>();
  final userController = Get.find<UserController>();
  final mainController = Get.find<MainController>();
  final state = Get.find<ProfileController>().state;

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "profile".tr,
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        children: [
          ObxValue((RxBool isLogged) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                16.verticalSpace,
                Visibility(
                  visible: isLogged.value == true,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration:
                        MyshapesStyle.PrimaryDecoration, // لون الخلفية هنا واضح
                    child: Row(
                      children: [
                        ClipOval(
                          child: MyImage(
                            image:
                                userController.user.value?.image ??
                                "assets/images/ic_profile.png",
                            fit: BoxFit.cover,
                            width: 70,
                            height: 70,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          children: [
                            Text(
                              userController.user.value?.name ?? "User Name",
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Zain',
                                fontWeight: FontWeight.w700,
                                height: 1.5,
                              ),
                            ),
                            Text(
                              userController.user.value?.phone ?? "User Phone",
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: Color(0xFFCCCAC7),
                                fontSize: 16,
                                fontFamily: 'Zain',
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: isLogged.value == true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 15,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap:
                                  () => Get.toNamed(
                                    Routes.MaintenanceAppointmentReminder,
                                  ),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: MyshapesStyle.PrimaryDecoration,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.alarm,
                                      color: colorPrimary,
                                    ),
                                    const SizedBox(width: 8),

                                    Flexible(
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          "appointment_reminder".tr,
                                          style: const TextStyle(
                                            color: Color(0xFFFFB727),
                                            fontSize: 16,
                                            fontFamily: 'Zain',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Get.toNamed(Routes.PRICEEQUEST_PAGE),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: MyshapesStyle.PrimaryDecoration,
                                child: Row(
                                  children: [
                                    const MyImage(
                                      image: "assets/images/ic_my_orderd.svg",
                                      width: 25,
                                      color: colorPrimary,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "price_request".tr,
                                      style: const TextStyle(
                                        color: Color(0xFFFFB727),
                                        fontSize: 16,
                                        fontFamily: 'Zain',
                                        fontWeight: FontWeight.w400,
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
                ),
                const SizedBox(height: 30),
                TextHeaderWidget(
                  title: isLogged.value == true ? "account".tr : null,
                  child: Column(
                    spacing: 8,
                    children: [
                      Visibility(
                        visible: isLogged.value == false,
                        child: SettingsItem(
                          title: "login".tr,
                          icon: "assets/images/ic_profile_edit.svg",
                          onClick: () {
                            Get.toNamed(Routes.LOGIN);
                          },
                        ),
                      ),
                      Visibility(
                        visible: isLogged.value == true,
                        child: SettingsItem(
                          title: "account_info".tr,
                          icon: "assets/images/ic_profile_edit.svg",
                          onClick: () {
                            Get.toNamed(Routes.PROFILE_EDIT);
                          },
                        ),
                      ),

                      Visibility(
                        visible: isLogged.value == true,
                        child: SettingsItem(
                          title: "settings_profile".tr,
                          icon: "assets/images/settings_profile.svg",
                          onClick: () {
                            Get.toNamed(Routes.AccountSetting);
                          },
                        ),
                      ),

                      SettingsItem(
                        title: "about_us".tr,
                        icon: "assets/images/ic_info.svg",
                        onClick: () {
                          Get.toNamed(Routes.ABOUT);
                        },
                      ),
                      SettingsItem(
                        title: "terms".tr,
                        icon: "assets/images/ic_terms.svg",
                        onClick: () {
                          Get.toNamed(Routes.TERMS);
                        },
                      ),

                      Visibility(
                        visible: isLogged.value == true,
                        child: SettingsItem(
                          title: "address".tr,
                          icon: "assets/images/ic_location.svg",
                          onClick: () {
                            Get.toNamed(Routes.AddressPage);
                          },
                        ),
                      ),
                      AuthItem(
                        title: "contact_us".tr,
                        icon: "assets/images/ic_whatsapp.svg",
                        onClick: () {
                          Get.toNamed(Routes.CONTACT_US);
                        },
                      ),
                      Visibility(
                        visible: isLogged.value == false,
                        child: LanguageWidget(),
                      ),
                      Column(
                        children: [
                          Visibility(
                            visible: isLogged.value == true,
                            child: AuthItem(
                              title: "logout".tr,
                              icon: "assets/images/ic_logout.svg",
                              bgColor: const Color(0xFFFF4C4C),
                              onClick: () {
                                Utils.showSheet(
                                  context,
                                  NormalSheet(
                                    child: CustomExistSheet(
                                      title: "logout".tr,
                                      onClick: () {
                                        userController.logout().then(
                                          (value) => Get.back(),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "follow_us".tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Zain',
                              fontWeight: FontWeight.w400,
                              height: 1.20,
                            ),
                          ),
                          const SizedBox(height: 8),

                          Obx(() {
                            var listSocials =
                                Get.find<MainController>().socials.value.data;
                            print("listSocialfdsfs: ${listSocials?.length}");

                            if (listSocials == null || listSocials.isEmpty) {
                              return const SizedBox.shrink();
                            }

                            return Wrap(
                              spacing: 10,
                              alignment: WrapAlignment.center,
                              children:
                                  listSocials.map<Widget>((social) {
                                    return GestureDetector(
                                      onTap: () {
                                        print("social.link: ${social.link}");
                                        LinkHelper.openLink(social.link ?? '');
                                      },
                                      child: MyImage(
                                        image: social.icon,
                                        width: 32,
                                        height: 32,
                                      ),
                                    );
                                  }).toList(),
                            );
                          }),

                          // authItem(
                          //   title: "remove_account".tr,
                          //   bgColor: Colors.red,
                          //   onClick: () {
                          //     showDialog(
                          //       context: context,
                          //       builder:
                          //           (
                          //             BuildContext context,
                          //           ) => CupertinoAlertDialog(
                          //             title: Text("remove_account".tr),
                          //             content: Text("remove_account_msg".tr),
                          //             actions: <Widget>[
                          //               CupertinoDialogAction(
                          //                 isDestructiveAction: true,
                          //                 child: Text("yes".tr),
                          //                 onPressed: () {
                          //                   userController.removeAccount();
                          //                   Navigator.pop(context);
                          //                 },
                          //               ),
                          //               CupertinoDialogAction(
                          //                 isDefaultAction: true,
                          //                 child: Text("no".tr),
                          //                 onPressed: () {
                          //                   Navigator.pop(context);
                          //                 },
                          //               ),
                          //             ],
                          //           ),
                          //     );
                          //   },
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }, userController.isLogged),
        ],
      ),
    );
  }

  Widget tocaanWidget(BuildContext context, PackageInfo? packageInfo) {
    return InkWell(
      onTap: () {
        Utils.customLaunch("https://tocaan.com");
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("Designed & Developed By", style: MyTextStyle.myBlackSubTitle),
            Text(
              "www.tocaan.com",
              style: MyTextStyle.myBlackSubTitle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "V ${packageInfo?.version ?? ""}",
              style: MyTextStyle.myBlackSubTitle,
            ),
          ],
        ),
      ),
    );
  }
}
