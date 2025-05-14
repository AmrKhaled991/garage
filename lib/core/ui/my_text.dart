import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/styles.dart';

class MyText extends StatelessWidget {
  const MyText(
      {Key? key,
      required this.text,
      this.color,
      this.backgroundColor,
      this.fontSize,
      this.fontWeight,
      this.fontStyle,
      this.padding,
      this.margin,
      this.height,
      this.textAlign,
      this.maxLines,
      this.overflow,
      this.crossedOut = false,
      this.fixFontTopPadding,
      this.fontFamily = appFontFamily})
      : super(key: key);

  final String? text;
  final Color? color;
  final Color? backgroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool crossedOut;
  final double? fixFontTopPadding;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    String content = text ?? '';
    if (content.isEmpty) {
      return Container();
    } else {
      Widget textWidget = Padding(
        padding: EdgeInsets.only(top: fixFontTopPadding ?? 5.h),
        child: Text(
          content,
          style: MyTextStyle.normalStyle.copyWith(
            fontFamily: fontFamily,
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            height: height,
            decoration: crossedOut ? TextDecoration.lineThrough : null,
          ),
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        ),
      );

      return Container(
        color: backgroundColor,
        padding: padding,
        margin: margin,
        child: textWidget,
      );
    }
  }
}
