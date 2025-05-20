// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/theme/styles.dart';

class SettingsItem extends StatelessWidget {
  String? title;
  VoidCallback? onClick;
  String? icon;
  Color? iconColor;
  Color? bgColor;
  SettingsItem({
    Key? key,
    this.title,
    this.icon,
    this.iconColor,
    this.bgColor,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: MyshapesStyle.PrimaryDecoration,
        child: Row(
          children: [
            if (icon != null)
              MyImage(image: icon, width: 30, color:iconColor?? colorPrimary),
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
}
