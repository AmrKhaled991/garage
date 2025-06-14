import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:garage/core/ui/AnimatedItem.dart';

class AnimatedGridView extends StatelessWidget {
  Widget Function(int) child;
  int itemCount;
  int? crossAxisCount;
  Axis scrollDirection;
  final EdgeInsetsGeometry? padding;
  SliverGridDelegate? gridDelegate;
  var aspectRatio;

  AnimatedGridView({
    Key? key,
    required this.child,
    this.itemCount = 0,
    this.padding,
    this.scrollDirection = Axis.vertical,
    this.gridDelegate,
    this.aspectRatio,
    this.crossAxisCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
        gridDelegate:
            gridDelegate ??
            SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount ?? 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: aspectRatio ?? 1,
            ),
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
