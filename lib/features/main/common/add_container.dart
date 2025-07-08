// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:garage/theme/styles.dart';

class AddContainer extends StatelessWidget {
  final Widget? content;
  final String title;
  final EdgeInsetsGeometry? padding;
  Function? onTap;
  AddContainer({
    Key? key,
    required this.title,
    this.padding,
    this.onTap,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: colorContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: InkWell(
        onTap: () {
          onTap?.call();
        },
        child:
            content ??
            Column(
              children: [
                const Icon(
                  Icons.add_circle_sharp,
                  color: Colors.white,
                  size: 24,
                ),
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
      ),
    );
  }
}
