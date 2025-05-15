import 'package:flutter/material.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';

import 'my_orders_controller.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyOrdersLogic logic = Get.put(MyOrdersLogic());

    return MyScaffold(
      title: "my_orders".tr,
      body:
      // const Center(child: EmptyWidget(title: "ليس لديك طلبات")),
      ListView.separated(
        itemBuilder: (context, index) => const OrderStatusCard(),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemCount: 3,
      ),
    );
  }
}

class OrderStatusCard extends StatelessWidget {
  const OrderStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.ORDER_DETAILSSKEY);
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
                const Text(
                  'رقم الطلب #٢٥٢٥',
                  style: TextStyle(
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
                    color: getbackgroundcolor("مكتمله"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'مكتمله',
                    textAlign: TextAlign.right,
                    style: TextStyle(
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
            const Text(
              'شركة المجد للصيانة',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFFCCCAC7),
                fontSize: 14,
                fontFamily: 'Zain',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
            const Text(
              'التكلفه: 5 دينار كويتي',
              textAlign: TextAlign.right,
              style: TextStyle(
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
              child: const Text(
                '44 طريق شارع الفهيدي, العاصمة, الكويت',
                textAlign: TextAlign.right,
                style: TextStyle(
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
      case "مكتمله":
        return const Color(0xFF065F46);
      case "قيد التنفيذ":
        return const Color(0xFF604106);
      case "قيد التنفيذ":
        return const Color(0xFF991B1B);
    }
    return null;
  }
}
