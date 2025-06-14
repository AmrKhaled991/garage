import 'package:flutter/material.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/features/all_chats/all_chat_details/all_chats_item_card.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';

class AllChatsPage extends StatelessWidget {
  const AllChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "all_chats".tr,
      body: ListView.separated(
        padding: const EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 100),
        itemBuilder:
            (context, index) => InkWell(
              onTap: () => Get.toNamed(Routes.CHAT),
              child: const AllChatsItemCard(),
            ),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemCount: 10,
      ),
    );
  }
}
