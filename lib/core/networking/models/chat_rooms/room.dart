import 'member.dart';

class Room {
  int? id;
  List<Member>? members;
  String? lastMessageBody;
  String? lastMessageCreatedAt;

  Room({
    this.id,
    this.members,
    this.lastMessageBody,
    this.lastMessageCreatedAt,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    id: json['id'] as int?,
    members:
        (json['members'] as List<dynamic>?)
            ?.map((e) => Member.fromJson(e as Map<String, dynamic>))
            .toList(),
    lastMessageBody: json['last_message_body'] as String?,
    lastMessageCreatedAt: json['last_message_created_at'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'members': members?.map((e) => e.toJson()).toList(),
    'last_message_body': lastMessageBody,
    'last_message_created_at': lastMessageCreatedAt,
  };
}
