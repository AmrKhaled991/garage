import 'package:garage/core/controllers/main_controller.dart';
import 'package:garage/core/ui/LoadingWidget.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:garage/utils/utlis.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'setting_controller.dart';

class SettingPage extends StatelessWidget {

  final mainController = Get.find<MainController>();
  final controller = Get.find<SettingController>();
  final state = Get.find<SettingController>().state;

  SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MyScaffold(
      title: "settings".tr,
      body: Column(
        children: [
          Expanded(
            child: ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  settingItem(
                      context,
                      "contact_us".tr,
                      icon: "assets/images/ic_contact.svg",
                      onClick: (){
                    Get.toNamed(Routes.CONTACT_US);
                  }
                      ),
                  Obx(() => LoadingWidget(
                    loadingState: mainController.pages.value,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: mainController.pages.value.data != null
                            ? mainController.pages.value.data?.length ?? 0
                            : 0,
                        itemBuilder: (context, index) {
                          var item = mainController.pages.value.data
                              ?.elementAt(index);
                          return settingItem(
                              context,
                              item?.title ?? "",
                              icon: item?.title?.toLowerCase().contains("terms") == true?
                                "assets/images/ic_terms.svg" : "assets/images/ic_info.svg",
                              onClick: () {
                                Get.toNamed(Routes.PAGE, arguments: {"page":
                                mainController.pages.value.data!.elementAt(index)});
                              });
                        }),
                  )),
                  languageWidget(context),
                ]),
          ),
          Obx(() => Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: tocaanWidget(context, mainController.packageInfo.value),
          )),
        ],
      ),
    );
  }

  Widget settingItem(BuildContext context, String title, {VoidCallback? onClick, String? icon, Color? iconColor, Color? bgColor}){
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(16),
          color: bgColor ?? Colors.white,
          border: Border.all(color: colorContainerBorder)
        ),
        child: Row(
          children: [
            if(icon!=null)
              MyImage(image: icon,width: 30,color: iconColor ),
            if(icon!=null)
              const SizedBox(width: 12,),
            Expanded(child: Text(title,
              style: MyTextStyle.myBlackSubTitle.copyWith(color: bgColor!=null? Colors.white : Colors.black),)),
            Icon(Icons.arrow_forward_ios, color: bgColor!=null? Colors.white : Colors.black, size: 15,)
          ],
        ),
      ),
    );
  }


  Widget languageWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(16),
        color: Colors.white,
          border: Border.all(color: colorContainerBorder)
      ),
      child: Row(
        children: [
          MyImage(image: "assets/images/ic_lang.svg",width: 30,),
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
                                ? Theme.of(context).primaryColor
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
                                ? Theme.of(context).primaryColor
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
