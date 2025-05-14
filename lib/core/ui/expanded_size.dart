import 'package:flutter/material.dart';

class ExpandedSize extends StatefulWidget {
  const ExpandedSize({
    Key? key,
    required this.child,
    this.expand = false,
    this.animate = true,
    this.width,
    this.height,
  }) : super(key: key);

  final Widget child;
  final double? width, height;
  final bool expand, animate;

  @override
  State<ExpandedSize> createState() => _ExpandedSizeState();
}

class _ExpandedSizeState extends State<ExpandedSize>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animate ? 500 : 0),
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(ExpandedSize oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: animation,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: widget.child,
      ),
    );
  }
}
