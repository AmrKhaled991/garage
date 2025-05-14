import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:garage/theme/styles.dart';

class CustomRichText extends StatelessWidget {
  final String text;
  final String tapText;
  final VoidCallback onTap;
  const CustomRichText({
    super.key,
    required this.text,
    required this.tapText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "${text.tr}  ",
              style: MyTextStyle.myGreySubTitle.copyWith(),
            ),
            TextSpan(
              recognizer:
                  TapGestureRecognizer()
                    ..onTap = () {
                      onTap.call();
                    },
              text: tapText.tr,
              style: MyTextStyle.mySecondarySubTitle,
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
