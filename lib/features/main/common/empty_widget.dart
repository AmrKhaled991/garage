import 'package:flutter/material.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:get/get.dart';

class EmptyWidget extends StatelessWidget {
  final String title;

  const EmptyWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 24,
      children: [
        const MyImage(image: "assets/images/empty.svg"),
        Text(
          title.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'Zain',
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
