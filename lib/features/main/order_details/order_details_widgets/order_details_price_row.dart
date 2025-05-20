import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';

class OrderDetailsPriceRow extends StatelessWidget {
  final String? title;
  final String? price;
  final Color? color;
  const OrderDetailsPriceRow({super.key, this.title, this.price, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title?.tr ?? "",
          textAlign: TextAlign.right,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontFamily: 'Zain',
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          price ?? '',
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontFamily: 'Zain',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
