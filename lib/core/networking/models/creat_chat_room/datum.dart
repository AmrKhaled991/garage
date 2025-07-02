class MessagesInfo {
  int? id;
  int? isSender;
  String? body;
  String? type;
  int? duration;
  String? name;
  String? createdAt;

  MessagesInfo({
    this.id,
    this.isSender,
    this.body,
    this.type,
    this.duration,
    this.name,
    this.createdAt,
  });

  factory MessagesInfo.fromJson(Map<String, dynamic> json) => MessagesInfo(
    id: json['id'] as int?,
    isSender: json['is_sender'] as int?,
    body: json['body'] as String?,
    type: json['type'] as String?,
    duration: json['duration'] as int?,
    name: json['name'] as String?,
    createdAt: json['created_at'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'is_sender': isSender,
    'body': body,
    'type': type,
    'duration': duration,
    'name': name,
    'created_at': createdAt,
  };
}
