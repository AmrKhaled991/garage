class MadeInCountry {
  int? id;
  String? name;
  String? key;
  String? flag;

  MadeInCountry({this.id, this.name, this.key, this.flag});

  factory MadeInCountry.fromJson(Map<String, dynamic> json) => MadeInCountry(
    id: json['id'] as int?,
    name: json['name'] as String?,
    key: json['key'] as String?,
    flag: json['flag'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'key': key,
    'flag': flag,
  };
}
