import 'package:intl/intl.dart';

class IntRepresentation {
  static String toReadableValue(String value) {
    try {
      return NumberFormat.compact().format(int.parse(value));
    } catch (error) {
      return value;
    }
  }

  static String toReadableTime(int? duration) {
    try {
      if (duration == null || duration == 0) return "";

      final minute = duration ~/ 60;
      final second = duration % 60;
      final zeroPadding = second < 10 ? '0' : '';
      return "$minute:$zeroPadding$second";
    } catch (error) {
      return "";
    }
  }
}
