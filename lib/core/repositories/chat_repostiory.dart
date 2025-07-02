import 'package:flutter/cupertino.dart';
import 'package:garage/core/networking/base/api_response.dart';
import 'package:garage/core/networking/base/dynamic_model.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/chat_rooms/chat_rooms.dart';
import 'package:garage/core/networking/models/creat_chat_room/creat_chat_room.dart';
import 'package:garage/core/networking/models/massage_chat/massage_chat.dart';
import 'package:garage/core/repositories/base_repository.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ChatRepository extends BaseRepository {
  Future<LoadingState<MyRooms>> getMyRooms() async {
    return await networkHandler.getRequest(
      endpoint: 'get-rooms',
      create: () => APIResponse<MyRooms>(create: () => MyRooms()),
    );
  }

  // CreateChatRoom

  Future<LoadingState<ChatRoom>> createChatRoom({
    required int providerId,
  }) async {
    var body = {
      'memberable_id': providerId.toString(),
      "memberable_type": "User",
    };
    return await networkHandler.postRequest(
      endpoint: 'create-private-room',
      body: FormData(body),
      create: () => APIResponse<ChatRoom>(create: () => ChatRoom()),
    );
  }

  Future<LoadingState<ChatRoom>> getChatRoomMessages({
    required int roomId,
    int page = 1,
  }) async {
    return await networkHandler.getRequest(
      endpoint: 'get-room-messages/$roomId?page=$page',
      create: () => APIResponse<ChatRoom>(create: () => ChatRoom()),
    );
  }

  //MassageChat
  Future<LoadingState<MassageChat>> sendMessage({
    required String message,
    required int roomId,
  }) async {
    var body = {'message': message};
    return await networkHandler.postRequest(
      endpoint: 'send-message/$roomId',
      body: FormData(body),
      create: () => APIResponse<MassageChat>(create: () => MassageChat()),
    );
  }

  //upload-room-file/:room_id
  Future<LoadingState<DynamicModel>> sendFile({
    required AssetEntity asset,
    required int roomId,
  }) async {
    var media = await asset.file;
    var file = MultipartFile(media, filename: 'file.jpg');
    var body = {'file': file};
    return await networkHandler.postRequest(
      endpoint: 'upload-room-file/$roomId',
      body: FormData(body),
      create: () => APIResponse<DynamicModel>(create: () => DynamicModel()),
    );
  }
}
