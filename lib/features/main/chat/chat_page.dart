import 'dart:io';

import 'package:flutter/material.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/features/main/chat/models/message_type.dart';
import 'package:get/get.dart';

import 'chat_controller.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController inputController = TextEditingController();
  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "direct_contact".tr,
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(12),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages.reversed.toList()[index];
                  return Align(
                    alignment:
                        message.isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (!message.isUser)
                          const CircleAvatar(
                            radius: 18,
                            backgroundColor: Color(0xff242424),
                            child: MyImage(
                              image: "assets/images/market.svg",
                              width: 16,
                            ),
                          ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(12),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          decoration: BoxDecoration(
                            color:
                                message.isUser
                                    ? Colors.white
                                    : Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child:
                              message.type == MessageType.text
                                  ? Text(
                                    message.content,
                                    style: TextStyle(
                                      color:
                                          message.isUser
                                              ? Colors.black
                                              : Colors.white,
                                    ),
                                  )
                                  : Image.file(
                                    File(message.content),
                                    height: 120,
                                  ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Obx(
            () =>
                controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : const SizedBox(),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.image, color: Colors.white),
                onPressed: () async {
                  // final picker = ImagePicker();
                  // final pickedFile = await picker.pickImage(
                  //   source: ImageSource.gallery,
                  // );
                  // if (pickedFile != null) {
                  //   controller.sendImage(pickedFile.path);
                  // }
                },
              ),
              Expanded(
                child: TextField(
                  controller: inputController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'اكتب رسالتك',
                    hintStyle: TextStyle(color: Colors.white38),
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: () {
                  if (inputController.text.trim().isNotEmpty) {
                    controller.sendMessage(inputController.text.trim());
                    inputController.clear();
                  }
                },
              ),
            ],
          ).paddingAll(12),
        ],
      ),
    );
  }
}
