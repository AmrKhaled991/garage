class Record {
  int? id;
  int? isActive;
  dynamic startDate;
  dynamic endDate;
  dynamic link;
  String? image;

  Record({
    this.id,
    this.isActive,
    this.startDate,
    this.endDate,
    this.link,
    this.image,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json['id'] as int?,
    isActive: json['is_active'] as int?,
    startDate: json['start_date'] as dynamic,
    endDate: json['end_date'] as dynamic,
    link: json['link'] as dynamic,
    image: json['image'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'is_active': isActive,
    'start_date': startDate,
    'end_date': endDate,
    'link': link,
    'image': image,
  };
}
