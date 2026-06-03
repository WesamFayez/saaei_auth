import 'package:intl/intl.dart';

String formatTime(String time24) {
  final inputFormat = DateFormat("HH:mm:ss"); // Input: 24-hour format
  final outputFormat = DateFormat("h a"); // Output: 12-hour with AM/PM

  final dateTime = inputFormat.parse(time24);
  return outputFormat.format(dateTime); // e.g., "3:00 PM"
}

String formatDate(String date) {
  final inputFormat = DateFormat("yyyy-MM-dd");
  final outputFormat = DateFormat("MMMM d"); // e.g., July 23, 2025

  final parsedDate = inputFormat.parse(date);
  return outputFormat.format(parsedDate);
}

String formatDateWithYear(String date) {
  final inputFormat = DateFormat("yyyy-MM-dd");
  final outputFormat = DateFormat("MMMM d, yyyy"); // e.g., July 23, 2025

  final parsedDate = inputFormat.parse(date);
  return outputFormat.format(parsedDate);
}

String getDayName(String date) {
  final inputFormat = DateFormat("yyyy-MM-dd");
  final outputFormat = DateFormat("EEEE"); // Full day name, e.g., Wednesday

  final parsedDate = inputFormat.parse(date);
  return outputFormat.format(parsedDate);
}
