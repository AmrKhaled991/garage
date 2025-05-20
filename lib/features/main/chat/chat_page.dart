import 'package:flutter/material.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:get/get.dart';

import 'chat_controller.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatController logic = Get.put(ChatController());

    return MyScaffold(
      title: "chat".tr,
      body: Center(
        child: Text(
          "chat".tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'Zain',
            fontWeight: FontWeight.w700,
            height: 1.20,
          ),
        ),
      ),
    );
  }
}
