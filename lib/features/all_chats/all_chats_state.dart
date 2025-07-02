import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/chat_rooms/chat_rooms.dart';
import 'package:get/get.dart';

class AllChatsState {
  var rooms = LoadingState<MyRooms>().obs;
  AllChatsState() {
    ///Initialize variables
  }
}
