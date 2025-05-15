import 'package:flutter/material.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/features/main/category/category_page_details/company_item_card.dart';
import 'package:garage/features/main/my_orders/my_orders_page.dart';
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
        itemBuilder: (context, index) => const OrderDetailsItemCard(),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemCount: 10,
      ),
      fab: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 43),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: MyshapesStyle.darkGrayDecoration,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              OrderDetailsPriceRow(
                title: "المجموع الفرعي (1 منتج)",
                price: "50 د.ك",
                color: DarkGrayPriceColor,
              ),
              OrderDetailsPriceRow(
                title: "رسوم التوصيل",
                price: "1 د.ك",
                color: DarkGrayPriceColor,
              ),
              OrderDetailsPriceRow(
                title: "الإجمالي ",
                price: "51 د.ك",
                color: DarkGrayPriceColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
          title ?? "",
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

class OrderDetailsItemCard extends StatelessWidget {
  const OrderDetailsItemCard({super.key});

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
                const Expanded(
                  child: Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'شركة جراج أونلاين للصيانه',

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Zain',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'مركز تغيير زيوت و صيانه سيارات',

                        style: TextStyle(
                          color: Color(0xFFCCCAC7),
                          fontSize: 12,
                          fontFamily: 'Zain',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '2 x 50 د.ك',

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Almarai',
                          fontWeight: FontWeight.w700,
                        ),
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
