import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AnimatedItem extends StatelessWidget {
  Widget child;
  int position;
  AnimatedItem({Key? key, required this.child ,required this.position}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
        position: position,
        duration: const Duration(milliseconds: 500),
        child: SlideAnimation(
            verticalOffset: 100,
            child: FadeInAnimation(child: child)
        )
    );
  }
}
