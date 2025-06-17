import 'package:flutter/material.dart';
import 'package:garage/core/networking/models/provider_details_response/product_model.dart';
import 'package:garage/core/ui/MyButton.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/core/ui/widgets/slider_view.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';

import 'product_details_controller.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductModel? productModel = Get.arguments;

  ProductDetailsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ProductDetailsController logic = Get.put(ProductDetailsController());

    return MyScaffold(
      title: "product_details".tr,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: MyshapesStyle.PrimaryDecoration,
              child: SliderView(
                items:
                    productModel?.images
                        ?.map((e) => MyImage(image: e.url))
                        .toList() ??
                    [
                      const MyImage(image: "assets/images/bar_bg.png"),
                      const MyImage(image: "assets/images/bar_bg.png"),
                      const MyImage(image: "assets/images/bar_bg.png"),
                      const MyImage(image: "assets/images/bar_bg.png"),
                    ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: MyshapesStyle.PrimaryDecoration,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 8,
                children: [
                  Text(
                    productModel?.name ?? 'بطارية فور جو 100 أمبير',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    productModel?.madeInCountry?.name ?? 'بلد المنشأ: الصين',
                    style: const TextStyle(
                      color: Color(0xFFCCCAC7),
                      fontSize: 14,
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    productModel?.price ?? '50 دينار كويتي',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 21),
            Text(
              productModel?.description ??
                  'وريم ايبسوم هو نموذج افتراضي يوضع في التصاميم لتعرض على العميل ليتصور طريقه وضع النصوص بالتصاميم سواء كانت تصاميم مطبوعه. وريم ايبسوم هو نموذج افتراضي يوضع في التصاميم لتعرض على العميل ليتصور طريقه وضع النصوص بالتصاميم سواء كانت تصاميم مطبوعه. وريم ايبسوم هو نموذج افتراضي يوضع في التصاميم لتعرض على العميل ليتصور طريقه وضع النصوص بالتصاميم سواء كانت تصاميم مطبوعه.',
              style: const TextStyle(
                color: Color(0xFFF7F8F9),
                fontSize: 16,
                fontFamily: 'Zain',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      fab: Container(
        color: colorBlack,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        child: Row(
          spacing: 8,
          children: [
            Expanded(
              child: MyButton(
                height: 50,
                title: "add_to_cart".tr,
                onClick: () {
                  // logic.addProductToCart();
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.50, color: Color(0xFF605D57)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'quantity'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Zain',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                  const Text(
                    '1',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Zain',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
