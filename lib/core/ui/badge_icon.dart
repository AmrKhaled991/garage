import 'package:flutter/material.dart';
import 'package:garage/core/ui/my_image.dart';

class BadgeIcon extends StatefulWidget {
  const BadgeIcon({
    Key? key,
    required this.itemCount,
    this.badgeColor= Colors.red,
    this.badgeTextColor= Colors.white,
    required this.image,
    this.matchTextDirection = false,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.semanticsLabel,
    this.color,
    this.padding,
    this.margin,
  }) : super(key: key);

  /// Number of items in the basket. When this is `0`, no badge will be shown.
  final int itemCount;
  final Color badgeColor;
  final Color badgeTextColor;

  final String? image;
  final bool matchTextDirection;
  final double? width, height;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final String? semanticsLabel;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  State<BadgeIcon> createState() => _BadgeIconState();
}

class _BadgeIconState extends State<BadgeIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  final Tween<Offset> _badgePositionTween = Tween(
    begin: const Offset(-0.5, 0.9),
    end: const Offset(0.0, 0.0),
  );

  @override
  void didUpdateWidget(covariant BadgeIcon oldWidget) {
    if (widget.itemCount != oldWidget.itemCount) {
      _animationController.reset();
      _animationController.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.elasticOut);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        MyImage(
          image: widget.image,
          matchTextDirection: widget.matchTextDirection,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          alignment: widget.alignment,
          semanticsLabel: widget.semanticsLabel,
          color: widget.color,
          padding: widget.padding,
          margin: widget.margin,
        ),
        Visibility(
          visible: widget.itemCount > 0,
          child: Positioned(
            bottom: -8.0,
            right: -3.0,
            child: SlideTransition(
              position: _badgePositionTween.animate(_animation),
              child: Material(
                  type: MaterialType.circle,
                  elevation: 2.0,
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      widget.itemCount.toString(),
                      style: TextStyle(
                        fontSize: 13.0,
                        color: widget.badgeTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
