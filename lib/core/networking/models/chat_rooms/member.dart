class Member {
  int? id;
  String? type;
  String? name;
  String? image;

  Member({this.id, this.type, this.name, this.image});

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    id: json['id'] as int?,
    type: json['type'] as String?,
    name: json['name'] as String?,
    image: json['image'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'name': name,
    'image': image,
  };
}
