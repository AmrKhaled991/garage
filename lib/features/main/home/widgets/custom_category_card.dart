// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';

class CustomCategoryCard extends StatelessWidget {
  final String image;
  final String text;
  Function? onTab;
  CustomCategoryCard({
    Key? key,
    required this.image,
    required this.text,
    this.onTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTab?.call(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        decoration: MyshapesStyle.PrimaryDecoration,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyImage(image: image, width: 40),
              const SizedBox(height: 16),
              Text(
                text.tr,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Zain',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
