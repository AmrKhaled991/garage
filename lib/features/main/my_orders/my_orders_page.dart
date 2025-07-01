import 'package:flutter/material.dart';
import 'package:garage/core/networking/models/my_order/my_order.dart';
import 'package:garage/core/ui/LoadingWidget.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';

import 'my_orders_controller.dart';

class MyOrdersPage extends StatelessWidget {
  final MyOrdersController controller = Get.find<MyOrdersController>();

  MyOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "my_orders".tr,
      body:
      // const Center(child: EmptyWidget(title: "ليس لديك طلبات")),
      Obx(() {
        return LoadingWidget(
          loadingState: controller.state.orders.value,
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 100),
            itemBuilder:
                (context, index) => OrderStatusCard(
                  order: controller.state.orders.value.data![index],
                ),
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemCount: controller.state.orders.value.data?.length ?? 0,
          ),
        );
      }),
    );
  }
}

class OrderStatusCard extends StatelessWidget {
  final MyOrder order;
  const OrderStatusCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.ORDER_DETAILSSKEY,
          arguments: {
            'orderId': order.id.toString(),
            'screenTitle': order.orderNumber.toString(),
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: MyshapesStyle.PrimaryDecoration,
        child: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${"order_number".tr}${order.orderNumber}',
                  style: const TextStyle(
                    color: Color(0xFFF7F8F9),
                    fontSize: 20,
                    fontFamily: 'Zain',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: ShapeDecoration(
                    color: getbackgroundcolor(order.orderStatusColor!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    order.payStatus ?? 'complete'.tr,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Zain',
                      fontWeight: FontWeight.w700,
                      height: 1.50,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              order.name ?? 'شركة المجد للصيانة',
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xFFCCCAC7),
                fontSize: 14,
                fontFamily: 'Zain',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
            Text(
              '${"cost".tr} ${order.finalTotal} ${"kwt_dinar".tr}',
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xFFFFB727),
                fontSize: 16,
                fontFamily: 'Zain',
                fontWeight: FontWeight.w700,
                height: 1.50,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,

              decoration: MyshapesStyle.lightGrayDecoration,
              child: Text(
                order.createdAt ?? '2023-01-01',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Zain',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color? getbackgroundcolor(String status) {
    switch (status) {
      case "completed":
        return const Color(0xFF065F46);
      case "pending":
        return const Color(0xFF604106);
      case "warning":
        return const Color(0xFF991B1B);
    }
    return null;
  }
}
