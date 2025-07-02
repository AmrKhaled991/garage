import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/repositories/chat_repostiory.dart';
import 'package:get/get.dart';

import 'all_chats_state.dart';

class AllChatsController extends GetxController {
  final AllChatsState state = AllChatsState();
  ChatRepository chatRepository = Get.find<ChatRepository>();
  @override
  void onInit() {
    super.onInit();
    fetchMyChats();
  }

  fetchMyChats() async {
    state.rooms.value = LoadingState.loading();
    state.rooms.value = await chatRepository.getMyRooms();
  }
}
