import 'package:garage/core/networking/base/decodable.dart';

import 'room.dart';

class MyRooms extends Decodable<MyRooms> {
  List<Room>? rooms;

  MyRooms({this.rooms});

  factory MyRooms.fromJson(Map<String, dynamic> json) => MyRooms(
    rooms:
        (json['rooms'] as List<dynamic>?)
            ?.map((e) => Room.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'rooms': rooms?.map((e) => e.toJson()).toList(),
  };

  @override
  MyRooms decode(json) {
    // TODO: implement decode
    return MyRooms.fromJson(json);
  }
}
