import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:garage/core/ui/AnimatedItem.dart';

class AnimatedListView extends StatelessWidget {
  Widget Function(int) child;
  int itemCount;
  Axis scrollDirection;
  final EdgeInsetsGeometry? padding;

  AnimatedListView({
    Key? key,
    required this.child,
    this.itemCount = 0,
    this.padding,
    this.scrollDirection = Axis.vertical,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        scrollDirection: scrollDirection,
        itemBuilder: (context, index) {
          return AnimatedItem(position: index, child: child(index));
        },
        itemCount: this.itemCount,
        physics: ClampingScrollPhysics(),
        padding: padding ?? EdgeInsets.all(16),
        shrinkWrap: true,
      ),
    );
  }
}
