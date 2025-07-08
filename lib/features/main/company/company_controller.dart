import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/creat_chat_room/creat_chat_room.dart';
import 'package:garage/core/repositories/categories_repository.dart';
import 'package:garage/core/repositories/chat_repostiory.dart';
import 'package:garage/utils/utlis.dart';
import 'package:get/get.dart';

import 'company_state.dart';

class CompanyController extends GetxController {
  final CompanyState state = CompanyState();
  final CategoriesRepository categoriesRepository = CategoriesRepository();
  final ChatRepository chatRepository = Get.find<ChatRepository>();

  var createRoomLoading = LoadingState<ChatRoom>().obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    state.id.value = Get.arguments;
    getProviderDetails();
  }

  createRoom( Function(bool,int roomId) onFinish, ) async {
    createRoomLoading.value = LoadingState.loading();
    createRoomLoading.value = await chatRepository.createChatRoom(
      providerId: state.id.value ?? 0,
    );
    onFinish(createRoomLoading.value.success,createRoomLoading.value.data?.room?.id ?? 0);
    if (createRoomLoading.value.success == false) {
      Utils.showSnackBar(createRoomLoading.value.message);
    }
  }

  void getProviderDetails() async {
    state.providerDetails.value = LoadingState.loading();
    state.providerDetails.value = await categoriesRepository.getProviderDetails(
      providerId: state.id.toString(),
    );
  }
}
