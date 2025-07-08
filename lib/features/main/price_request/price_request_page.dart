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
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'price_request_controller.dart';

class PriceRequestPage extends StatefulWidget {
  const PriceRequestPage({Key? key}) : super(key: key);

  @override
  State<PriceRequestPage> createState() => _PriceRequestPageState();
}

class _PriceRequestPageState extends State<PriceRequestPage> {
  PriceRequestController controller = Get.find<PriceRequestController>();

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "price_request".tr,
      body: SmartRefresher(
        header: const WaterDropHeader(),
        controller: _refreshController,
        physics: const BouncingScrollPhysics(),
        onRefresh:
            () => {
              controller.state.pagingController.refresh(),
              _refreshController.refreshCompleted(),
            },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: PagedListView<int, UserPricesRequest>(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            pagingController: controller.state.pagingController,
            padding: const EdgeInsets.all(8),
            builderDelegate: PagedChildBuilderDelegate<UserPricesRequest>(
              itemBuilder:
                  (context, item, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: RequestPriceItemCard(item: item),
                  ),
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
        Get.toNamed(Routes.PriceRequestDetailsPageKEY, arguments: item);
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
                  '${"رقم الطلب ".tr}${item.orderNumber}',
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
                    color: getbackgroundcolor(item.status ?? ''),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    (item.status?.replaceAll('admin.', '').tr ?? ''),
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
              item.details ?? "",
              style: const TextStyle(
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

  Color? getbackgroundcolor(String status) {
    switch (status) {
      case "admin.completed":
        return const Color(0xFF065F46);
      case "admin.new":
        return const Color(0xFF604106);
      case "admin.warning":
        return const Color(0xFF991B1B);
    }
    return null;
  }
}
