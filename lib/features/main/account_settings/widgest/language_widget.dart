import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/core/controllers/main_controller.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';

class LanguageWidget extends StatelessWidget {
  final MainController mainController = Get.find<MainController>();

  LanguageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
