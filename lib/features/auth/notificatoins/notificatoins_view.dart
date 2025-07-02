import 'package:flutter/material.dart';
import 'package:garage/core/networking/models/user_notification/user_notification.dart';
import 'package:garage/core/ui/my_error_widget.dart';
import 'package:garage/core/ui/my_loading_widget.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'notificatoins_logic.dart';

class NotificatoinsPage extends StatefulWidget {
  const NotificatoinsPage({Key? key}) : super(key: key);

  @override
  State<NotificatoinsPage> createState() => _NotificatoinsPageState();
}

class _NotificatoinsPageState extends State<NotificatoinsPage> {
  final NotificatoinsLogic controller = Get.put(NotificatoinsLogic());

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "Notifications".tr,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: SmartRefresher(
          header: const WaterDropHeader(),
          controller: _refreshController,
          physics: const BouncingScrollPhysics(),
          onRefresh:
              () => {
                controller.state.pagingController.refresh(),
                _refreshController.refreshCompleted(),
              },
          child: PagedListView<int, UserNotification>(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            pagingController: controller.state.pagingController,
            padding: const EdgeInsets.all(8),
            builderDelegate: PagedChildBuilderDelegate<UserNotification>(
              itemBuilder:
                  (context, item, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Container(
                      decoration: MyshapesStyle.PrimaryDecoration,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          spacing: 16,
                          children: [
                            const Icon(
                              Icons.notifications,
                              color: colorPrimary,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title ?? "title".tr,
                                    style: MyTextStyle.myBlackBoldLargeTitle
                                        .copyWith(fontSize: 16),
                                  ),
                                  Text(
                                    item.body ?? "body".tr,
                                    style: MyTextStyle.myBlackBoldLargeTitle
                                        .copyWith(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
    );
  }
}
