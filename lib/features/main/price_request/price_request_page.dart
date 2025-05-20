import 'package:flutter/material.dart';
import 'package:garage/core/ui/MyButton.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';

import 'price_request_controller.dart';

class PriceRequestPage extends StatelessWidget {
  const PriceRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PriceRequestController controller = Get.put(PriceRequestController());

    return MyScaffold(
      title: "price_request".tr,
      body:
      // const EmptyWidget(title: "لا يوجد طلبات"),
      ListView.separated(
        padding: const EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 100),
        itemBuilder: (context, index) => const RequestPriceItemCard(),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemCount: 10,
      ),
      fab: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        color: colorBlack,
        child: MyButton(
          title: "price_request".tr,
          onClick: () => {Get.toNamed(Routes.AddPriceRequest)},
        ),
      ),
    );
  }
}

class RequestPriceItemCard extends StatelessWidget {
  const RequestPriceItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.PriceRequestDetailsPageKEY);
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
                    color: const Color(0xFF604106),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'complete'.tr,
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
            const Text(
              "طقم سماعات سيارة",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFFCCCAC7),
                fontSize: 14,
                fontFamily: 'Zain',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),

            Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,

              decoration: MyshapesStyle.lightGrayDecoration,
              child: const Text(
                "تاريخ الطلب: 15 مارس, 2025 - 08:30 م",
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
}
