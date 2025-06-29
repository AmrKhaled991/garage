// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:garage/core/networking/models/user_prices_request/user_prices_request.dart';
import 'package:garage/core/ui/MyButton.dart';
import 'package:garage/core/ui/my_error_widget.dart';
import 'package:garage/core/ui/my_loading_widget.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';

import 'price_request_controller.dart';

class PriceRequestPage extends StatefulWidget {
  const PriceRequestPage({Key? key}) : super(key: key);

  @override
  State<PriceRequestPage> createState() => _PriceRequestPageState();
}

class _PriceRequestPageState extends State<PriceRequestPage> {
  PriceRequestController controller = Get.find<PriceRequestController>();

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "price_request".tr,
      body: PagedListView<int, UserPricesRequest>(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        pagingController: controller.state.pagingController,
        padding: const EdgeInsets.all(8),
        builderDelegate: PagedChildBuilderDelegate<UserPricesRequest>(
          itemBuilder:
              (context, item, index) => RequestPriceItemCard(item: item),
          firstPageProgressIndicatorBuilder: (_) => const MyLoadingWidget(),
          newPageProgressIndicatorBuilder: (_) => const MyLoadingWidget(),
          noItemsFoundIndicatorBuilder:
              (_) => MyErrorWidget(
                onRetryCall: () {
                  controller.state.pagingController.refresh();
                },
                errorMsg: "no_data_found".tr,
                errorType: ErrorType.EMPTY,
              ),
          firstPageErrorIndicatorBuilder:
              (_) => MyErrorWidget(
                onRetryCall: () {
                  controller.state.pagingController.refresh();
                },
                errorMsg: controller.state.pagingController.error
                    .toString()
                    .substring(
                      controller.state.pagingController.error
                              .toString()
                              .lastIndexOf("(") +
                          2,
                      controller.state.pagingController.error
                              .toString()
                              .length -
                          2,
                    ),
                withLogin: true,
              ),
        ),
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
  final UserPricesRequest item;
  const RequestPriceItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.PriceRequestDetailsPageKEY ,arguments: item);
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
              child: Text(
                "تاريخ الطلب: ${item.createdAt.toString().substring(0, 10)}",
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
}
