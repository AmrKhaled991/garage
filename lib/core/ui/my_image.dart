import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:garage/theme/styles.dart';

class MyImage extends StatelessWidget {
  const MyImage({
    Key? key,
    required this.image,
    this.matchTextDirection = false,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.semanticsLabel,
    this.color,
    this.backgroundColor,
    this.backgroundGradient,
    this.padding,
    this.margin,
  }) : super(key: key);

  final String? image;
  final bool matchTextDirection;
  final double? width, height;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final String? semanticsLabel;
  final Color? color, backgroundColor;
  final Gradient? backgroundGradient;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    String imagePath = image ?? '';

    Widget? imageWidget;
    if (imagePath.startsWith("assets")) {
      if (imagePath.endsWith(".svg")) {
        imageWidget = SvgPicture.asset(
          imagePath,
          matchTextDirection: matchTextDirection,
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
          semanticsLabel: semanticsLabel,
          color: color,
        );
      } else {
        imageWidget = Image.asset(
          imagePath,
          matchTextDirection: matchTextDirection,
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
          semanticLabel: semanticsLabel,
          color: color,
        );
      }
    } else if (imagePath.startsWith("http")) {
      if (imagePath.endsWith(".svg")) {
        imageWidget = SvgPicture.network(
          imagePath,
          matchTextDirection: matchTextDirection,
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
          semanticsLabel: semanticsLabel,
          color: color,
        );
      } else {
        imageWidget = CachedNetworkImage(
          imageUrl: imagePath,
          // placeholder: (context, url) => MyImage(
          //   padding: EdgeInsets.all(10.r),
          //   image: "assets/images/logo.svg",
          //   backgroundColor: colorMain,
          // ),
          placeholder:
              (context, url) =>
                  const Center(child: CupertinoActivityIndicator(radius: 10)),
          errorWidget:
              (context, url, error) => const MyImage(
                margin: EdgeInsets.all(8),
                image: "assets/images/logo2.svg",
              ),
          matchTextDirection: matchTextDirection,
          width: width,
          height: height,
          fit: fit,
          // alignment: alignment,
          // semanticLabel: semanticsLabel,
          color: color,
        );
      }
    } else if (imagePath.startsWith("/storage/") ||
        imagePath.startsWith("/data/")) {
      if (imagePath.endsWith(".svg")) {
        imageWidget = SvgPicture.file(
          File(imagePath),
          matchTextDirection: matchTextDirection,
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
          semanticsLabel: semanticsLabel,
          color: color,
        );
      } else {
        imageWidget = Image.file(
          File(imagePath),
          matchTextDirection: matchTextDirection,
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
          semanticLabel: semanticsLabel,
          color: color,
        );
      }
    }

    if (imageWidget != null) {
      return Container(
        padding: padding,
        margin: margin,
        clipBehavior: Clip.none,
        decoration: BoxDecoration(
          color: backgroundColor,
          gradient: backgroundGradient,
        ),
        child: imageWidget,
      );
    }

    return Container();
  }
}
