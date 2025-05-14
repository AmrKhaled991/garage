import 'package:flutter/material.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';

class CustomCompanyListTileButton extends StatelessWidget {
  final String title;
  final Function? onPress;
  const CustomCompanyListTileButton({
    super.key,
    required this.title,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress != null ? onPress!() : null,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: colorPrimary, strokeAlign: 1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      ),
      child:  Text(
        title.tr,
        textAlign: TextAlign.right,
        style: TextStyle(
          color: Color(0xFFFFB727),
          fontSize: 12,
          fontFamily: 'Zain',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
