import 'package:flutter/material.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/features/main/common/order_price_details_card.dart';
import 'package:garage/features/main/order_details/order_details_widgets/order_details_item_card.dart';
import 'package:garage/features/main/order_details/order_details_widgets/order_details_price_row.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "order_details".tr,
      body: ListView.separated(
        padding: const EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 150),
        itemBuilder:
            (context, index) =>
                GestureDetector(child: const OrderDetailsItemCard()),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemCount: 10,
      ),
      fab: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 43),
        child: OrderPriceDetailsCard(),
      ),
    );
  }
}
