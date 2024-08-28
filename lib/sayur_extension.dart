import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String dateFormat(String format) => DateFormat(format).format(this);
  DateTime parseDateTime(String format) => DateFormat(format).parse(toString());
}

extension StringExtension on String {
  String dateFormat(String format) {
    if (isEmpty) return '';
    return DateFormat(format).format(DateTime.parse(this));
  }

  String parseDateTime(String format) {
    if (isEmpty) return '';
    return DateFormat(format).parse(this).toString();
  }

  String changeDateFormat({
    required String oldFormat,
    required String newFormat,
  }) {
    if (isEmpty) return '';
    return DateFormat(newFormat).format(DateFormat(oldFormat).parse(this));
  }

  bool isValidEmail() => RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(this);

  bool isValidPhone() => RegExp(r'^[0-9]{10,13}$').hasMatch(this);

  bool isValidNik() => RegExp(r'^[0-9]{16}$').hasMatch(this);

  String toCapitalize() {
    if (isEmpty) return '';
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String toCapitalizeEachCase() {
    if (isEmpty) return '';

    return split(' ')
        .where((word) => word.isNotEmpty)
        .map((word) =>
            "${word[0].toUpperCase()}${word.substring(1).toLowerCase()}")
        .toList()
        .join(' ');
  }

  String toRupiah() =>
      NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
          .format(int.parse(this));
  String toDollar() =>
      NumberFormat.currency(locale: 'en', symbol: '\$', decimalDigits: 0)
          .format(int.parse(this));

  String toAge() {
    DateTime now = DateTime.now();
    DateTime birth = DateTime.parse(this);
    int ageInYears = now.year - birth.year;

    if (now.month < birth.month ||
        (now.month == birth.month && now.day < birth.day)) {
      ageInYears--;
    }

    return "$ageInYears tahun";
  }

  String toHours() {
    DateTime now = DateTime.now(), time = DateTime.parse(this);
    int diff = now.difference(time).inMinutes;

    return diff.toDigitalTime();
  }

  String toHoursMinuteNonNumeric() {
    DateTime now = DateTime.now(), time = DateTime.parse(this);
    int diff = now.difference(time).inMinutes;
    String hour = (diff ~/ 60).toString(), minute = (diff % 60).toString();
    return "$hour jam $minute menit";
  }

  String toMinuteNonNumeric() {
    DateTime now = DateTime.now();
    DateTime time = DateTime.parse(this);
    int diff = now.difference(time).inMinutes;

    return "$diff menit";
  }

  int toInt() => int.parse(this);
  DateTime toDateTime() => DateTime.parse(this);
}

extension IntExtension on int {
  String toDigitalTime() {
    int hour = this ~/ 60;
    int minutes = this % 60;

    String hourStr = hour.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');

    return '$hourStr:$minutesStr';
  }

  String toDigitalHourMinuteSecondTime() {
    int hour = this ~/ 3600;
    int minutes = (this % 3600) ~/ 60;
    int seconds = this % 60;

    String hourStr = hour.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return '$hourStr:$minutesStr:$secondsStr';
  }
}

extension TruthyExtension<T> on T {
  bool get isTruthy {
    if (this != null) return false;
    if (this is bool) return this == true;
    if (this is num) return this != 0;
    if (this is String) return (this as String).isNotEmpty;
    if (this is Iterable) return (this as Iterable).isNotEmpty;
    if (this is Map) return (this as Map).isNotEmpty;

    return true;
  }

  bool get isFalsy => !isTruthy;
}
