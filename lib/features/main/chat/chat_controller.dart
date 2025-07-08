import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/creat_chat_room/creat_chat_room.dart';
import 'package:garage/core/networking/models/creat_chat_room/datum.dart';
import 'package:garage/core/networking/models/user_notification/user_notification.dart';
import 'package:garage/core/repositories/chat_repostiory.dart';
import 'package:garage/features/main/chat/models/message_type.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'chat_state.dart';

class ChatController extends GetxController {
  final ChatState state = ChatState();
  ChatRepository chatRepository = Get.find<ChatRepository>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchChatRoomMessages();
  }

  int? chatId = Get.arguments;
  var chatMessages = LoadingState<ChatRoom>().obs;

  var messages = <MessageModel>[].obs;
  var isLoading = false.obs;
  var sendingLoading = false.obs;
  fetchChatRoomMessages() async {
    isLoading.value = true;
    chatMessages.value = LoadingState.loading();
    chatMessages.value = await chatRepository.getChatRoomMessages(
      roomId: chatId!,
    );
    chatMessages.value.data?.messages?.data?.forEach((element) {
      messages.add(
        MessageModel(
          content: element.body ?? "",
          type: MessageType.text,
          isUser: element.isSender == 1,
        ),
      );
    });
    isLoading.value = false;
  }

  sendUserMessage(String text) async {
    sendingLoading.value = true;
    var result = await chatRepository.sendMessage(
      message: text,
      roomId: chatId!,
    );
    if (result.success) {
      var chatMessages = await chatRepository.getChatRoomMessages(
        roomId: chatId!,
      );
      messages.clear();
      chatMessages.data?.messages?.data?.forEach((element) {
        messages.add(
          MessageModel(
            content: element.body ?? "",
            type: MessageType.text,
            isUser: element.isSender == 1,
          ),
        );
      });
    }
    sendingLoading.value = false;
  }

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
    await Future.delayed(const Duration(seconds: 2));
    messages.add(
      MessageModel(
        content: "رد تلقائي على: $userInput",
        type: MessageType.text,
        isUser: false,
      ),
    );
    isLoading.value = false;
  }

  // void onInit() {
  //   super.onInit();
  //   pagingController.addPageRequestListener((pageKey) {
  //     getRoomMessages(pageKey);
  //   });
  // }

  // Future<void> getRoomMessages(int pageKey) async {
  //   try {
  //     final response = await chatRepository.getChatRoomMessages(
  //       roomId: chatId!,
  //       page: pageKey,
  //     );

  //     final isLastPage =
  //         response.pagination?.currentPage == response.pagination?.totalPages;
  //     if (isLastPage) {
  //       pagingController.appendLastPage(response.data?.messages?.data ?? []);
  //     } else {
  //       final nextPageKey = pageKey + 1;
  //       pagingController.appendPage(
  //         response.data?.messages?.data ?? [],
  //         nextPageKey,
  //       );
  //     }
  //   } catch (error) {
  //     pagingController.error = error;
  //   }
  // }
}
