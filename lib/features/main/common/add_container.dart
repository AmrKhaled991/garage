// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';

class AddContainer extends StatelessWidget {
  final String title;
  const AddContainer({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: colorContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        children: [
          const Icon(Icons.add_circle_sharp, color: Colors.white, size: 24),
          const SizedBox(height: 8),

          Text(
            title.tr,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Zain',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
