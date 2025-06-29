import 'package:flutter/material.dart';
import 'package:garage/core/controllers/cart_controller.dart';
import 'package:garage/core/networking/models/provider_details_response/product_model.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/theme/styles.dart';
import 'package:garage/utils/utlis.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProductItemCard extends StatelessWidget {
  final Function? onTap;
  final ProductModel? productModel;
  const ProductItemCard({super.key, this.onTap, this.productModel});

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.find();
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Column(
        spacing: 9,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: MyshapesStyle.SecondaryDecoration,
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: MyImage(
                        image: productModel?.image ?? "assets/images/logo1.svg",
                        fit: BoxFit.scaleDown,
                        width: 110,
                        height: 110,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: IconButton(
                    onPressed: () {
                      cartController.addToCart(
                        productModel!.id!,
                        1,
                        onFinish: (value) {
                          if (value)
                            Utils.showSnackBar(
                              "item_added_to_cart_successfully".tr,
                            );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.add_circle_rounded,
                      color: colorPrimary,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            productModel?.name ?? 'بطارية فور جو 100 أمبير',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Zain',
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            productModel?.madeInCountry?.name ?? 'بلد المنشأ: الصين',
            style: const TextStyle(
              color: Color(0xFFCCCAC7),
              fontSize: 12,
              fontFamily: 'Zain',
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            productModel?.price ?? '50 دينار كويتي',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Zain',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
