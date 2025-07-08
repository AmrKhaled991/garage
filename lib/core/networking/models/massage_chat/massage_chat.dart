import 'package:garage/core/networking/base/decodable.dart';

import 'original_message.dart';

class MassageChat extends Decodable<MassageChat> {
  int? messageId;
  int? roomId;
  int? userableId;
  String? userableType;
  int? isFlagged;
  int? isSeen;
  int? isSender;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  List<dynamic>? otherUsers;
  OriginalMessage? originalMessage;

  MassageChat({
    this.messageId,
    this.roomId,
    this.userableId,
    this.userableType,
    this.isFlagged,
    this.isSeen,
    this.isSender,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.otherUsers,
    this.originalMessage,
  });

  factory MassageChat.fromJson(Map<String, dynamic> json) => MassageChat(
    messageId: json['message_id'] as int?,
    roomId: json['room_id'] as int?,
    userableId: json['userable_id'] as int?,
    userableType: json['userable_type'] as String?,
    isFlagged: json['is_flagged'] as int?,
    isSeen: json['is_seen'] as int?,
    isSender: json['is_sender'] as int?,
    updatedAt:
        json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
    createdAt:
        json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
    id: json['id'] as int?,
    otherUsers: json['other_users'] as List<dynamic>?,
    originalMessage:
        json['original_message'] == null
            ? null
            : OriginalMessage.fromJson(
              json['original_message'] as Map<String, dynamic>,
            ),
  );

  Map<String, dynamic> toJson() => {
    'message_id': messageId,
    'room_id': roomId,
    'userable_id': userableId,
    'userable_type': userableType,
    'is_flagged': isFlagged,
    'is_seen': isSeen,
    'is_sender': isSender,
    'updated_at': updatedAt?.toIso8601String(),
    'created_at': createdAt?.toIso8601String(),
    'id': id,
    'other_users': otherUsers,
    'original_message': originalMessage?.toJson(),
  };

  @override
  MassageChat decode(json) {
    // TODO: implement decode
    return MassageChat.fromJson(json);
  }
}
