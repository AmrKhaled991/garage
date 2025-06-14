import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';

class CartButton extends StatefulWidget {
  /// The function to call when the icon button is pressed.
  final VoidCallback? onPressed;

  /// Number of items in the basket. When this is `0`, no badge will be shown.
  final int? itemCount;

  final Color badgeColor;

  final Color badgeTextColor;

  CartButton({
    Key? key,
    @required this.itemCount,
    this.onPressed,
    this.badgeColor = Colors.red,
    this.badgeTextColor = Colors.white,
  }) : assert((itemCount ?? 0) >= 0),
       assert(badgeColor != null),
       assert(badgeTextColor != null),
       super(key: key);

  @override
  CartButtonState createState() {
    return CartButtonState();
  }
}

class CartButtonState extends State<CartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  final Tween<Offset> _badgePositionTween = Tween(
    begin: const Offset(-0.5, 0.9),
    end: const Offset(0.0, 0.0),
  );

  @override
  Widget build(BuildContext context) {
    // if (widget.itemCount == 0) {
    //   return IconButton(
    //     icon: Icon(Icons.shopping_cart),
    //     onPressed: widget.onPressed,
    //   );
    // }

    return Material(
      color: Colors.transparent,
      child: IconButton(
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            SvgPicture.asset(
              "assets/images/ic_cart.svg",
              color: Colors.white,
              height: 25,
            ),
            Positioned(
              bottom: -8.0,
              right: -3.0,
              child: SlideTransition(
                position: _badgePositionTween.animate(_animation),
                child: Material(
                  type: MaterialType.circle,
                  elevation: 2.0,
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      widget.itemCount.toString(),
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        onPressed: () {
          // Get.toNamed(Routes.CART);
        },
      ),
    );
  }

  @override
  void didUpdateWidget(CartButton oldWidget) {
    if (widget.itemCount != oldWidget.itemCount) {
      _animationController.reset();
      _animationController.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );
    _animationController.forward();
  }
}
