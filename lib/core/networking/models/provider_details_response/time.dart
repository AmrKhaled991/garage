class Time {
  int? id;
  int? userId;
  String? day;
  String? start;
  String? end;
  DateTime? createdAt;
  DateTime? updatedAt;

  Time({
    this.id,
    this.userId,
    this.day,
    this.start,
    this.end,
    this.createdAt,
    this.updatedAt,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
    id: json['id'] as int?,
    userId: json['user_id'] as int?,
    day: json['day'] as String?,
    start: json['start'] as String?,
    end: json['end'] as String?,
    createdAt:
        json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
    updatedAt:
        json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'day': day,
    'start': start,
    'end': end,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}
