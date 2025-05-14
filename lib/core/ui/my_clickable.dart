import 'package:flutter/material.dart';
import 'package:garage/theme/styles.dart';

class MyClickable extends StatelessWidget {
  const MyClickable({
    Key? key,
    required this.child,
    this.onPressed,
    this.padding,
    this.margin,
    this.isEnabled = true,
    this.cornerRadius,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool isEnabled;
  final double? cornerRadius;

  @override
  Widget build(BuildContext context) {
    Widget button = TextButton(
      style: TextButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        minimumSize: Size.zero,
        padding: padding ?? EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: colorWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(cornerRadius ?? 5),
          ),
        ),
      ),
      onPressed: isEnabled ? onPressed : null,
      child: child,
    );

    if (margin != null) {
      return Container(
        margin: margin,
        child: button,
      );
    } else {
      return button;
    }
  }
}
