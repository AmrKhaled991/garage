import 'package:flutter/material.dart';
import 'package:garage/core/ui/MyButton.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';

class AttentionPage extends StatelessWidget {
  String? image;
  Color? imageColor;
  String? description;
  String? buttonTitle;
  bool expanded;
  VoidCallback? onClick;
  AttentionPage({
    this.image,
    this.description,
    this.imageColor,
    this.buttonTitle,
    this.onClick,
    this.expanded = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (expanded)
            ? Expanded(
              child: MyImage(
                image: image ?? "",
                width: Get.width / 2,
                color: imageColor,
              ),
            )
            : MyImage(
              image: image ?? "",
              width: 200,
              height: 200,
              color: imageColor,
            ),
        Text(
          description ?? "",
          style: MyTextStyle.myGreyTitle,
          textAlign: TextAlign.center,
        ).marginAll(16),
        Visibility(
          visible: buttonTitle != null,
          child: MyButton(title: buttonTitle ?? "", onClick: onClick),
        ),
      ],
    ).marginAll(16);
  }
}
