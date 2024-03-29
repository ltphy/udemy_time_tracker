import 'package:intl/intl.dart';

class Format {
  Format._();

  static final Format instance = Format._();

  String hours(double hours) {
    final hoursNotNegative = hours < 0.0 ? 0.0 : hours;
    final decimalPattern = NumberFormat.decimalPattern();
    final formatted = decimalPattern.format(hoursNotNegative);
    return '${formatted}h';
  }
  // format2020 Jul 15
  String date(DateTime date) {
    final dateFormat = DateFormat.yMMMd('en_US');
    return dateFormat.format(date);
  }

  String dayOfWeek(DateTime date) {
    final dateFormat = DateFormat.E();
    return dateFormat.format(date);
  }

  String currency(double value) {
    final currencyFormat = NumberFormat.currency(locale: 'en_US');
    return currencyFormat.format(value);
  }
}
