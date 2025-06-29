// ignore_for_file: public_member_api_docs, sort_constructors_first
class TimeSlot {
  String? day;
  String? start;
  String? end;
  bool isSelected = false;

  TimeSlot({this.day, this.start, this.end, required this.isSelected});

  Map<String, dynamic> toJson() => {"day": day, "start": start, "end": end};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeSlot && runtimeType == other.runtimeType && day == other.day;

  @override
  int get hashCode => day.hashCode;
}
