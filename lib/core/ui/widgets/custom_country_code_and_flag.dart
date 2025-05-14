import 'package:flutter/material.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/theme/styles.dart';

class TextFormFieldIcon extends StatelessWidget {
  final String assets;
  const TextFormFieldIcon({super.key, required this.assets});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 14),

          MyImage(image: assets, width: 24, height: 24, fit: BoxFit.cover),
          const SizedBox(width: 14),
          SizedBox(
            height: 50,
            child: VerticalDivider(
              color: colorDarkGrey.withAlpha(50),
              width: 3,
              thickness: 2,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
