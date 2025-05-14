import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage/core/controllers/main_controller.dart';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/ui/MyButton.dart';
import 'package:garage/core/ui/btn_social.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../utils/utlis.dart';
import 'profile_controller.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final controller = Get.find<ProfileController>();
  final userController = Get.find<UserController>();
  final mainController = Get.find<MainController>();
  final state = Get
      .find<ProfileController>()
      .state;


  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "profile".tr,
      body: ListView(
          padding: EdgeInsets.zero,
          children: [
            ObxValue((RxBool isLogged) =>
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    16.verticalSpace,
                    Visibility(
                      visible: isLogged.value,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              ClipOval(
                                child: MyImage(
                                  image: userController.user.value?.image,
                                  fit: BoxFit.cover,
                                  width: 70,
                                  height: 70,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                    onTap: (){
                                      Get.toNamed(Routes.PROFILE_EDIT);
                                    },
                                    child: MyImage(
                                      image: "assets/images/ic_edit.svg",
                                      width: 30,
                                    )
                                ),
                              )
                            ],
                          ),
                          8.verticalSpace,
                          Text(userController.user.value?.name??"", style: MyTextStyle.myBlackBoldTitle,),
                          Text(userController.user.value?.email??"", style: MyTextStyle.myBlackTitle,),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: colorContainer,
                        borderRadius: BorderRadius.circular(16)
                      ),
                      margin: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Visibility(
                            visible: isLogged.value == false,
                            child: settingItem(
                                title: "login".tr,
                                icon: "assets/images/ic_profile_edit.svg",
                                onClick: (){
                                  Get.toNamed(Routes.LOGIN);
                                }
                            ),
                          ),
                          Visibility(
                            visible: isLogged.value == true,
                            child: settingItem(
                                title: "edit_profile".tr,
                                icon: "assets/images/ic_profile_edit.svg",
                                onClick: (){
                                  Get.toNamed(Routes.PROFILE_EDIT);
                                }
                            ),
                          ),
                          settingItem(
                              title: "contact_us".tr,
                              icon: "assets/images/ic_contact.svg",
                              onClick: (){
                                Get.toNamed(Routes.CONTACT_US);
                              }
                          ),
                          settingItem(
                              title: "about_app".tr,
                              icon: "assets/images/ic_info.svg",
                              onClick: () {
                                Get.toNamed(Routes.ABOUT);
                              }
                          ),
                          settingItem(
                              title: "terms".tr,
                              icon: "assets/images/ic_terms.svg",
                              onClick: () {
                                Get.toNamed(Routes.TERMS);
                              }
                          ),
                          settingItem(
                              title: "share_app".tr,
                              icon: "assets/images/ic_share.svg",
                              onClick: (){

                              }
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
                                      }),
                                  authItem(
                                      title: "remove_account".tr,
                                      bgColor: Colors.red,
                                      onClick: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                CupertinoAlertDialog(
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
                                                    )
                                                  ],
                                                )
                                        );
                                      }),
                                ]
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(() => Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: tocaanWidget(context, mainController.packageInfo.value),
                    )),
                  ],
                ), userController.isLogged
            ),
          ],
        ),
    );
  }

  Widget settingItem({String? title, VoidCallback? onClick, String? icon, Color? iconColor, Color? bgColor}){
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        child: Row(
          children: [
            if(icon!=null)
              MyImage(image: icon,width: 30,color: iconColor ),
            if(icon!=null)
              const SizedBox(width: 12,),
            Expanded(child: Text(title??"",
              style: MyTextStyle.myBlackSubTitle,)),
            Icon(Icons.arrow_forward_ios, color: colorGrey, size: 15,)
          ],
        ),
      ),
    );
  }

  Widget authItem({String? title, VoidCallback? onClick, String? icon, Color? iconColor, Color? bgColor}){
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(16),
          color: bgColor ?? colorContainer,
        ),
        child: Row(
          children: [
            if(icon!=null)
              MyImage(image: icon,width: 25,color: iconColor ),
            if(icon!=null)
              const SizedBox(width: 12,),
            Expanded(child: Text(title??"",
              style: MyTextStyle.myBlackSubTitle.copyWith(color: bgColor!=null? Colors.white : Colors.black),)),
            Icon(Icons.arrow_forward_ios, color: colorGrey, size: 15,)
          ],
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
              child: MyImage(image: "assets/images/ic_lang.svg",width: 25 )),
          const SizedBox(width: 12,),
          Expanded(
              child: Text(
                "language".tr,
                style: MyTextStyle.myBlackSubTitle,
              )),
          Flex(direction: Axis.horizontal, children: <Widget>[
            Obx(() => Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: const ShapeDecoration(
                  shape: StadiumBorder(), color: Colors.white60),
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
                            color: (mainController.language.value == "en")
                                ? colorPrimary
                                : null),
                        child: Text(
                          "English",
                          style: MyTextStyle.myBlackSubTitle
                              .copyWith(
                              color: (mainController.language.value == "en")
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        mainController.toggleLanguage();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: ShapeDecoration(
                            shape: const StadiumBorder(),
                            color: (mainController.language.value == "ar")
                                ? colorPrimary
                                : null),
                        child: Text(
                          "العربيه",
                          style: MyTextStyle.myBlackSubTitle
                              .copyWith(
                              color: (mainController.language.value == "ar")
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
          ]),
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
            Text(
              "Designed & Developed By",
              style: MyTextStyle.myBlackSubTitle,
            ),
            Text(
              "www.tocaan.com",
              style: MyTextStyle.myBlackSubTitle
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              "V ${packageInfo?.version??""}",
              style: MyTextStyle.myBlackSubTitle,
            ),
          ],
        ),
      ),
    );
  }
}
