class Room {
  int? id;

  Room({this.id});

  factory Room.fromJson(Map<String, dynamic> json) =>
      Room(id: json['id'] as int?);

  Map<String, dynamic> toJson() => {'id': id};
}
