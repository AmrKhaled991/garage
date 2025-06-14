import 'package:flutter/material.dart';
import 'package:garage/core/ui/MyButton.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/features/main/cart/car_details/item_counter.dart';
import 'package:garage/features/main/common/order_price_details_card.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "cart".tr,
      body: ListView.separated(
        padding: const EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 165),
        itemBuilder: (context, index) => const CartItemCard(),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemCount: 10,
      ),
      fab: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          children: [
            const OrderPriceDetailsCard(),
            MyButton(
              title: "continue".tr,
              onClick: () {
                Get.toNamed(Routes.COMPLETE_CART_ORDER);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CartItemCard extends StatelessWidget {
  const CartItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: MyshapesStyle.PrimaryDecoration,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.zero,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: const MyImage(
                    image: "assets/images/bar_bg.png",
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'شركة جراج أونلاين للصيانه',

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Zain',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Text(
                        'مركز تغيير زيوت و صيانه سيارات',

                        style: TextStyle(
                          color: Color(0xFFCCCAC7),
                          fontSize: 12,
                          fontFamily: 'Zain',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Text(
                        '2 x 50 د.ك',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Almarai',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      ItemCounter(
                        counter: (counter) {
                          print("counter $counter");
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
