// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/theme/styles.dart';

class AuthItem extends StatelessWidget {
    String? title;
    VoidCallback? onClick;
    String? icon;
    Color? iconColor;
    Color? bgColor;
    bool? hasIcon = true;
    bool? borderRadius = false;
   AuthItem({
    Key? key,
    this.title,
    this.onClick,
    this.icon,
    this.iconColor,
    this.bgColor,
     this.hasIcon,
     this.borderRadius,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: MyshapesStyle.PrimaryDecoration,
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
                    color: bgColor ?? Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
