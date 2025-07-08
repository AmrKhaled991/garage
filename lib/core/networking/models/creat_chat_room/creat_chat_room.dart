import 'package:garage/core/networking/base/decodable.dart';

import 'member.dart';
import 'messages.dart';
import 'room.dart';

class ChatRoom extends Decodable<ChatRoom> {
  Room? room;
  List<Member>? members;
  Messages? messages;

  ChatRoom({this.room, this.members, this.messages});

  factory ChatRoom.fromJson(Map<String, dynamic> json) => ChatRoom(
    room:
        json['room'] == null
            ? null
            : Room.fromJson(json['room'] as Map<String, dynamic>),
    members:
        (json['members'] as List<dynamic>?)
            ?.map((e) => Member.fromJson(e as Map<String, dynamic>))
            .toList(),
    messages:
        json['messages'] == null
            ? null
            : Messages.fromJson(json['messages'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'room': room?.toJson(),
    'members': members?.map((e) => e.toJson()).toList(),
    'messages': messages?.toJson(),
  };

  @override
  ChatRoom decode(json) {
    // TODO: implement decode
    return ChatRoom.fromJson(json);
  }
}
