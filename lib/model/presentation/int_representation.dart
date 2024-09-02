import 'package:intl/intl.dart';

class IntRepresentation {
  static String toReadableValue(String value) {
    try {
      return NumberFormat.compact().format(double.parse(value));
    } catch (error) {
      return value;
    }
  }
}
