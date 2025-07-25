import 'package:flutter/material.dart';
import 'package:garage/core/controllers/cart_controller.dart';
import 'package:garage/core/networking/models/cart/data.dart';
import 'package:garage/core/networking/models/cart/item.dart';
import 'package:garage/core/ui/LoadingWidget.dart';
import 'package:garage/core/ui/MyButton.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/features/main/cart/car_details/item_counter.dart';
import 'package:garage/features/main/common/empty_widget.dart';
import 'package:garage/features/main/common/order_price_details_card.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);

  final RefreshController _refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "cart".tr,
      body: Center(
        child: GetBuilder<CartController>(
          initState: (_) {
            Get.find<CartController>().getCartItems(false);
          },
          builder: (controller) {
            return LoadingWidget(
              loadingState: controller.cart.value,
              isEmpty: controller.cart.value.data?.items?.isEmpty == true,
              emptyWidget: EmptyWidget(title: "cart_empty".tr),
              child: SmartRefresher(
                header: const WaterDropHeader(),
                controller: _refreshController,
                physics: const BouncingScrollPhysics(),
                onRefresh:
                    () => {
                      controller.getCartItems(false),
                      _refreshController.refreshCompleted(),
                    },
                child: ListView.separated(
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 8,
                    right: 8,
                    bottom: 165,
                  ),
                  itemBuilder:
                      (context, index) => CartItemCard(
                        cartItem:
                            controller.cart.value.data?.items?[index] ??
                            CartItem(),
                      ),
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 8),
                  itemCount: controller.cart.value.data?.items?.length ?? 0,
                ),
              ),
            );
          },
        ),
      ),
      fab: Obx(() {
        final controller = Get.find<CartController>();
        var isVisible = controller.cart.value.data?.items?.isNotEmpty == true;

        return isVisible
            ? AnimatedOpacity(
              opacity: isVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Visibility(
                visible: isVisible,
                maintainState: true,
                maintainSize: true,
                maintainAnimation: true,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OrderPriceDetailsCard(
                        deliveryPrice:
                            controller.cart.value.data?.deliveryPrice ?? 0,
                        totalPrice:
                            controller
                                .cart
                                .value
                                .data
                                ?.items
                                ?.first
                                .totalPrice ??
                            0,
                      ),
                      const SizedBox(height: 10),
                      MyButton(
                        title: "continue".tr,
                        onClick: () {
                          Get.toNamed(Routes.COMPLETE_CART_ORDER);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
            : const SizedBox.shrink();
      }),
    );
  }
}

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  const CartItemCard({super.key, required this.cartItem});

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
                  child: MyImage(
                    image:
                        cartItem.product?.image ?? "assets/images/bar_bg.png",
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              Text(
                                cartItem.product?.name ??
                                    'شركة جراج أونلاين للصيانه',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Zain',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                cartItem.product?.description ??
                                    'مركز تغيير زيوت و صيانه سيارات',
                                style: const TextStyle(
                                  color: Color(0xFFCCCAC7),
                                  fontSize: 12,
                                  fontFamily: 'Zain',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                '${cartItem.product?.price ?? 0} رد.ك',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Almarai',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),

                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              Get.find<CartController>().removeFromCart(
                                cartItem.product?.id.toString() ?? '',
                              );
                            },
                          ),
                        ],
                      ),
                      ItemCounter(
                        itemId: cartItem.product?.id ?? 0,
                        quantity: cartItem.quantity ?? 0,
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
