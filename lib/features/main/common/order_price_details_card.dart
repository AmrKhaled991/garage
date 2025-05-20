import 'package:flutter/material.dart';
import 'package:garage/features/main/order_details/order_details_widgets/order_details_price_row.dart';
import 'package:garage/theme/styles.dart';

class OrderPriceDetailsCard extends StatelessWidget {
  const OrderPriceDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: MyshapesStyle.darkGrayDecoration,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          OrderDetailsPriceRow(
            title: "sub_total",
            price: "50 د.ك",
            color: DarkGrayPriceColor,
          ),
          OrderDetailsPriceRow(
            title: "delivery_fee",
            price: "1 د.ك",
            color: DarkGrayPriceColor,
          ),
          OrderDetailsPriceRow(
            title: "total",
            price: "51 د.ك",
            color: DarkGrayPriceColor,
          ),
        ],
      ),
    );
  }
}
