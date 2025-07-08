class OriginalMessage {
  int? id;
  int? roomId;
  String? senderableType;
  int? senderableId;
  String? body;
  dynamic name;
  String? type;
  int? duration;
  DateTime? createdAt;
  DateTime? updatedAt;

  OriginalMessage({
    this.id,
    this.roomId,
    this.senderableType,
    this.senderableId,
    this.body,
    this.name,
    this.type,
    this.duration,
    this.createdAt,
    this.updatedAt,
  });

  factory OriginalMessage.fromJson(Map<String, dynamic> json) {
    return OriginalMessage(
      id: json['id'] as int?,
      roomId: json['room_id'] as int?,
      senderableType: json['senderable_type'] as String?,
      senderableId: json['senderable_id'] as int?,
      body: json['body'] as String?,
      name: json['name'] as dynamic,
      type: json['type'] as String?,
      duration: json['duration'] as int?,
      createdAt:
          json['created_at'] == null
              ? null
              : DateTime.parse(json['created_at'] as String),
      updatedAt:
          json['updated_at'] == null
              ? null
              : DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'room_id': roomId,
    'senderable_type': senderableType,
    'senderable_id': senderableId,
    'body': body,
    'name': name,
    'type': type,
    'duration': duration,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}
