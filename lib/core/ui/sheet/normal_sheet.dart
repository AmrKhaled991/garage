import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:garage/theme/styles.dart';

class NormalSheet extends StatelessWidget {
  final String? title;
  final Widget? child;

  const NormalSheet({Key? key, this.child, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 16),
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // key to wrap content
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                decoration: ShapeDecoration(
                  shape: const StadiumBorder(),
                  color: Colors.grey.shade400,
                ),
                height: 5,
                width: 100,
              ),
            ),
            if (title != null) ...[
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  title!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Zain',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}
