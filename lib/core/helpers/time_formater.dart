import 'package:intl/intl.dart';

class DateTimeFormatter {
  /// Returns a DateTime with time set to midnight (00:00)
  static DateTime atMidnight(DateTime dt) =>
      DateTime(dt.year, dt.month, dt.day);

  /// Formats a DateTime to "00:00" (24-hour, zero-padded)
  static String formatHour24(DateTime dt) => DateFormat('HH:mm').format(dt);
 static String convert24to12(String time24) {
  final dateTime = DateFormat('HH:mm').parse(time24);
  return DateFormat('hh:mm a').format(dateTime);
}

  /// Formats a DateTime to "12:00 AM" style (12-hour with AM/PM)
  static String formatHour12(DateTime dt) => DateFormat('hh:mm a').format((dt));

  /// Formats a DateTime to "DD/MM/YYYY"
  static String formatDateDMY(DateTime dt) =>
      DateFormat('dd/MM/yyyy').format(dt);

  /// Full DateTime combined: "DD/MM/YYYY hh:mm a"
  static String formatDateTimeDMY12(DateTime dt) =>
      '${formatDateDMY(dt)} ${dt}';

  static String formatTo12Hour(String time24) {
    final inputFormat = DateFormat.Hms(); // "15:55:00"
    final outputFormat = DateFormat('hh:mm a'); // "03:55 PM"
    final dateTime = inputFormat.parse(time24);
    return outputFormat.format(dateTime);
  }
}
