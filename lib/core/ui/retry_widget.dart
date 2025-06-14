import 'package:garage/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class RetryWidget extends StatelessWidget {
  RetryWidget(this.click, {this.msg});

  final VoidCallback click;
  final String? msg;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          (msg == null || msg?.isEmpty == true)
              ? "error_try_again".tr
              : msg ?? "",
          style: MyTextStyle.myBlackTitle,
        ),
        SizedBox(height: 16),
        MaterialButton(child: Text("retry".tr), onPressed: click),
      ],
    );
  }
}
