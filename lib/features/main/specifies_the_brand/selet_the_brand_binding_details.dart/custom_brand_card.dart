// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:garage/core/networking/models/brand/brand.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/theme/styles.dart';

class CustomBrandCard extends StatelessWidget {
  final bool isSelected;
  final Brand? brand;
  const CustomBrandCard({Key? key, required this.isSelected, this.brand})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: colorContainer,
        border: Border.all(
          color: isSelected ? colorPrimary : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(8),
      ),

      child: Column(
        children: [
          MyImage(image: brand?.image ?? '', width: 40),
          const SizedBox(height: 10),
          FittedBox(
            fit: BoxFit.scaleDown,

            child: Text(
              brand?.name?.tr ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Zain',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
