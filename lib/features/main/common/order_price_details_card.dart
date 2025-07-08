import 'package:flutter/material.dart';
import 'package:garage/features/main/order_details/order_details_widgets/order_details_price_row.dart';
import 'package:garage/theme/styles.dart';

class OrderPriceDetailsCard extends StatelessWidget {
  final int? deliveryPrice;
  final int totalPrice;

  const OrderPriceDetailsCard({
    super.key,
    required this.deliveryPrice,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: MyshapesStyle.darkGrayDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          OrderDetailsPriceRow(
            title: "sub_total",
            price: "$totalPrice د.ك",
            color: DarkGrayPriceColor,
          ),
          if (deliveryPrice != null)
            OrderDetailsPriceRow(
              title: "delivery_fee",
              price: "$deliveryPrice د.ك",
              color: DarkGrayPriceColor,
            ),
          OrderDetailsPriceRow(
            title: "total",
            price: "${totalPrice + (deliveryPrice ?? 0)} د.ك",
            color: DarkGrayPriceColor,
          ),
        ],
      ),
    );
  }
}
