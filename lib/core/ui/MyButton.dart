import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:garage/theme/styles.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    this.title,
    this.onClick,
    this.vPading = 12,
    this.width,
    this.height,
    this.child,
    this.color,
    this.textColor,
    this.withGradient = false,
    this.isOutline = false,
    this.isFullWidth = true,
    this.borderRadius,
  });

  final VoidCallback? onClick;
  final String? title;
  final double vPading;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Widget? child;
  final Color? color;
  final Color? textColor;
  final bool? withGradient;
  final bool? isOutline;
  final bool? isFullWidth;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClick,
      style: TextButton.styleFrom(padding: EdgeInsets.zero),

      child: Container(
        alignment: Alignment.center,
        width: width ?? (isFullWidth == true ? Get.width : null),
        height: height ?? 50,
        padding: EdgeInsets.symmetric(vertical: vPading, horizontal: 16),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: color ?? colorPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        //
        // BoxDecoration(
        //   color:
        //       withGradient == true || isOutline == true
        //           ? null
        //           : (color ?? colorPrimary),
        //   borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 100)),
        //   gradient: withGradient == true ? appGradient : null,
        //   border:
        //       isOutline == false ? null : Border.all(color: color ?? colorGrey),
        // ),
        child:
            child ??
            Text(
              title ?? "",
              style: MyTextStyle.myBlackTitle.copyWith(
                color: textColor,
                fontSize: 18,
                fontFamily: 'Zain',
                fontWeight: FontWeight.w700,
              ),
            ),
      ),
    );
  }
}
