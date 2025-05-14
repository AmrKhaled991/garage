// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextHeaderWidget extends StatelessWidget {
  final String title;
  final Widget child;
  const TextHeaderWidget({Key? key, required this.child, required this.title})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          title.tr,
          textAlign: TextAlign.right,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Zain',
            fontWeight: FontWeight.w700,
            height: 1.50,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}
