import 'package:garage/features/main/chat/models/message_type.dart';
import 'package:get/get.dart';

import 'chat_state.dart';

class ChatController extends GetxController {
  final ChatState state = ChatState();
  var messages = <MessageModel>[].obs;
  var isLoading = false.obs;

  Future<void> sendMessage(String text) async {
    messages.add(
      MessageModel(content: text, type: MessageType.text, isUser: true),
    );
    await getBotResponse(text);
  }

  Future<void> sendImage(String path) async {
    messages.add(
      MessageModel(content: path, type: MessageType.image, isUser: true),
    );
    await getBotResponse("[image sent]");
  }

  Future<void> getBotResponse(String userInput) async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2));
    messages.add(
      MessageModel(
        content: "رد تلقائي على: $userInput",
        type: MessageType.text,
        isUser: false,
      ),
    );
    isLoading.value = false;
  }
}
