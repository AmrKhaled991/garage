import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:garage/theme/styles.dart';

class NormalSheet extends StatelessWidget {
  final String? title;
  final Widget? child;

  const NormalSheet({Key? key, this.child, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 1,
      minChildSize: 0.9,
      initialChildSize: 1,
      // snap: false,
      expand: true,
      builder: (BuildContext context, ScrollController scrollController) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: colorBlack,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: Container(
                      decoration: ShapeDecoration(
                        shape: const StadiumBorder(),
                        color: Colors.grey.shade400,
                      ),
                      height: 5,
                      width: 100,
                    ),
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                color: colorBlack,
                width: double.infinity,
                child: Text(
                  title ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Zain',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(child: child ?? Container()),
            ],
          ),
        );
      },
    );
  }
}
