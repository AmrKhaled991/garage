// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/core/ui/MyButton.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';

class CustomExistSheet extends StatelessWidget {
  String? title;
  Function? onClick;
  CustomExistSheet({Key? key, this.title, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title?.tr ?? "",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'Zain',
            fontWeight: FontWeight.w700,
            height: 1.20,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "${"are_you_sure".tr}$title?",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Zain',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            spacing: 8,
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: colorBlack,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(
                        color: Colors.white,
                        strokeAlign: 1,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 13,
                    ),
                  ),
                  child: Text(
                    'cancel'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Zain',
                      fontWeight: FontWeight.w700,
                      height: 1.50,
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              Expanded(
                child: MyButton(
                  color: colorBadge,
                  textColor: Colors.white,
                  height: 55,
                  title: title?.tr,
                  isOutline: true,
                  onClick: () {
                    onClick?.call();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
