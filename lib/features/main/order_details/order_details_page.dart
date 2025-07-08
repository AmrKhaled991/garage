import 'package:flutter/material.dart';
import 'package:garage/core/networking/models/my_orders_details/item.dart';
import 'package:garage/core/networking/models/my_orders_details/my_orders_details.dart';
import 'package:garage/core/ui/LoadingWidget.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/features/main/common/order_price_details_card.dart';
import 'package:garage/features/main/order_details/order_details_controller.dart';
import 'package:garage/features/main/order_details/order_details_widgets/order_details_item_card.dart';
import 'package:get/get.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderDetailsController controller =
        Get.find<OrderDetailsController>();

    return MyScaffold(
      title: "${"order_details".tr} ${controller.title}",
      body: Obx(() {
        return LoadingWidget(
          loadingState: controller.state.orders.value,
          child: ListView.separated(
            padding: const EdgeInsets.only(
              top: 16,
              left: 8,
              right: 8,
              bottom: 150,
            ),
            itemBuilder:
                (context, index) => GestureDetector(
                  child: OrderDetailsItemCard(
                    item:
                        controller.state.orders.value.data?.items![index] ??
                        OrderDetailsItem(),
                  ),
                ),
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemCount: controller.state.orders.value.data?.items?.length ?? 0,
          ),
        );
      }),
      fab: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 34.0),
        child: Obx(() {
          var isVisible =
              controller.state.orders.value.data?.items?.isNotEmpty ?? false;
          return isVisible
              ? AnimatedOpacity(
                opacity: isVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Visibility(
                  visible: isVisible,
                  maintainState: true,
                  maintainSize: true,
                  maintainAnimation: true,
                  child: OrderPriceDetailsCard(
                    deliveryPrice:
                        controller.state.orders.value.data?.deliveryPrice ?? 0,
                    totalPrice:
                        controller
                            .state
                            .orders
                            .value
                            .data
                            ?.items
                            ?.first
                            .totalPrice ??
                        0,
                  ),
                ),
              )
              : const SizedBox.shrink();
        }),
      ),
    );
  }
}
