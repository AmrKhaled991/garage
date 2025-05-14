import 'package:garage/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class MyLoadingButton extends StatefulWidget {
  const MyLoadingButton({
    super.key,
    this.title,
    this.onClick,
    this.width,
    this.child,
    this.color,
    this.withGradient = false,
  });

  final Function(RoundedLoadingButtonController)? onClick;
  final String? title;
  final double? width;
  final Widget? child;
  final Color? color;
  final bool? withGradient;

  @override
  State<MyLoadingButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyLoadingButton> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: widget.color ?? colorPrimary,
        gradient: widget.withGradient == true ? appGradient : null,
        borderRadius: BorderRadius.circular(8),
      ),
      width: widget.width ?? Get.width,
      child: RoundedLoadingButton(
        height: 50,
        child:
            widget.child ??
            Text(widget.title ?? "", style: MyTextStyle.myBlackTitle),
        controller: _btnController,
        color: widget.color ?? colorPrimary,
        borderRadius: 8,
        elevation: 0,
        width: widget.width ?? Get.width,
        onPressed: () {
          widget.onClick?.call(_btnController);
        },
      ),
    );
  }
}
