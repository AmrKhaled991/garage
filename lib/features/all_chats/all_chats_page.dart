import 'package:flutter/material.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/chat_rooms/room.dart';
import 'package:garage/core/ui/LoadingWidget.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/features/all_chats/all_chat_details/all_chats_item_card.dart';
import 'package:garage/features/all_chats/all_chats_controller.dart';
import 'package:garage/features/main/common/empty_widget.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllChatsPage extends StatelessWidget {
  AllChatsPage({Key? key}) : super(key: key);

  var refreshController = RefreshController(initialRefresh: false);
  var controller = Get.find<AllChatsController>();

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "all_chats".tr,
      body: Obx(() {
        return LoadingWidget(
          isEmpty: controller.state.rooms.value.data?.rooms?.isEmpty == true,
          loadingState: controller.state.rooms.value,
          emptyWidget: Center(child: EmptyWidget(title: "no_chats".tr)),
          child: SmartRefresher(
            controller: refreshController,
            header: const WaterDropHeader(),
            onRefresh: () {
              controller.fetchMyChats();
              refreshController.refreshCompleted();
            },
            child: ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(
                top: 16,
                left: 8,
                right: 8,
                bottom: 100,
              ),
              itemBuilder:
                  (context, index) => InkWell(
                    onTap:
                        () => Get.toNamed(
                          Routes.CHAT,
                          arguments:
                              controller
                                  .state
                                  .rooms
                                  .value
                                  .data
                                  ?.rooms?[index]
                                  .id,
                        ),
                    child: AllChatsItemCard(
                      room:
                          controller.state.rooms.value.data?.rooms?[index] ??
                          Room(),
                    ),
                  ),
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemCount: controller.state.rooms.value.data?.rooms?.length ?? 0,
            ),
          ),
        );
      }),
    );
  }
}
