import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage/core/controllers/main_controller.dart';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/ui/MyButton.dart';
import 'package:garage/core/ui/btn_social.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/features/main/common/text_header_widget.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
          ObxValue(
            (RxBool isLogged) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                16.verticalSpace,
                Visibility(
                  visible: true,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration:
                        MyshapesStyle.PrimaryDecoration, // لون الخلفية هنا واضح
                    child: const Row(
                      children: [
                        ClipOval(
                          child: MyImage(
                            image: "assets/images/bar_header.png",
                            fit: BoxFit.cover,
                            width: 70,
                            height: 70,
                          ),
                        ),
                        SizedBox(width: 12),
                        Column(
                          children: [
                            Text(
                              'محمد أحمد سعد',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Zain',
                                fontWeight: FontWeight.w700,
                                height: 1.5,
                              ),
                            ),
                            Text(
                              '+965 121564564522',
                              textAlign: TextAlign.right,
                              style: TextStyle(
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
                  visible: true,
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Row(
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
                                child: const Row(
                                  children: [
                                    Icon(Icons.alarm, color: colorPrimary),
                                    SizedBox(width: 8),

                                    Text(
                                      'تذكير موعد',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
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
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Get.toNamed(Routes.PRICEEQUEST_PAGE),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: MyshapesStyle.PrimaryDecoration,
                                child: const Row(
                                  children: [
                                    MyImage(
                                      image: "assets/images/ic_my_orderd.svg",
                                      width: 25,
                                      color: colorPrimary,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'طلب عرض سعر',
                                      style: TextStyle(
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
                  title: "acount".tr,
                  child: Column(
                    spacing: 8,
                    children: [
                      Visibility(
                        visible: isLogged.value == false,
                        child: settingItem(
                          title: "login".tr,
                          icon: "assets/images/ic_profile_edit.svg",
                          onClick: () {
                            Get.toNamed(Routes.LOGIN);
                          },
                        ),
                      ),
                      Visibility(
                        visible: isLogged.value == true,
                        child: settingItem(
                          title: "edit_profile".tr,
                          icon: "assets/images/ic_profile_edit.svg",
                          onClick: () {
                            Get.toNamed(Routes.PROFILE_EDIT);
                          },
                        ),
                      ),
                      settingItem(
                        title: "contact_us".tr,
                        icon: "assets/images/ic_contact.svg",
                        onClick: () {
                          Get.toNamed(Routes.CONTACT_US);
                        },
                      ),
                      settingItem(
                        title: "about_app".tr,
                        icon: "assets/images/ic_info.svg",
                        onClick: () {
                          Get.toNamed(Routes.ABOUT);
                        },
                      ),
                      settingItem(
                        title: "terms".tr,
                        icon: "assets/images/ic_terms.svg",
                        onClick: () {
                          Get.toNamed(Routes.TERMS);
                        },
                      ),
                      settingItem(
                        title: "Address".tr,
                        icon: "assets/images/ic_location.svg",
                        onClick: () {
                          Get.toNamed(Routes.AddressPage);
                        },
                      ),
                      settingItem(
                        title: "share_app".tr,
                        icon: "assets/images/ic_share.svg",
                        onClick: () {},
                      ),
                      languageWidget(context),
                      Visibility(
                        visible: isLogged.value,
                        child: Column(
                          children: [
                            authItem(
                              title: "logout".tr,
                              icon: "assets/images/ic_logout.svg",
                              bgColor: colorSecondary,
                              onClick: () {
                                userController.logout();
                              },
                            ),
                            authItem(
                              title: "remove_account".tr,
                              bgColor: Colors.red,
                              onClick: () {
                                showDialog(
                                  context: context,
                                  builder:
                                      (
                                        BuildContext context,
                                      ) => CupertinoAlertDialog(
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
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: tocaanWidget(
                      context,
                      mainController.packageInfo.value,
                    ),
                  ),
                ),
              ],
            ),
            userController.isLogged,
          ),
        ],
      ),
    );
  }

  Widget settingItem({
    String? title,
    VoidCallback? onClick,
    String? icon,
    Color? iconColor,
    Color? bgColor,
  }) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: MyshapesStyle.PrimaryDecoration,
        child: Row(
          children: [
            if (icon != null)
              MyImage(image: icon, width: 30, color: colorPrimary),
            if (icon != null) const SizedBox(width: 12),
            Expanded(
              child: Text(
                title ?? "",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Zain',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: colorGrey, size: 15),
          ],
        ),
      ),
    );
  }

  Widget authItem({
    String? title,
    VoidCallback? onClick,
    String? icon,
    Color? iconColor,
    Color? bgColor,
    bool hasIcon = true,
    bool borderRadius = false,
  }) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius:
              borderRadius == false
                  ? null
                  : BorderRadiusDirectional.circular(8),
          color: bgColor ?? colorContainer,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(16),
          ),
          child: Row(
            children: [
              if (icon != null)
                MyImage(image: icon, width: 25, color: iconColor),
              if (icon != null) const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title ?? "",
                  style: MyTextStyle.myBlackSubTitle.copyWith(
                    color: bgColor != null ? Colors.white : Colors.black,
                  ),
                ),
              ),
              if (hasIcon) ...[
                const Icon(Icons.arrow_forward_ios, color: colorGrey, size: 15),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget languageWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(6),
              color: colorContainer,
            ),
            child: const MyImage(
              image: "assets/images/ic_lang.svg",
              width: 25,
              color: colorPrimary,
            ),
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
                    color: Colors.white60,
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
