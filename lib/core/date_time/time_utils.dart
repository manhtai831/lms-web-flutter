import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeUtils {
  static String dateFormat = "dd/MM/yyyy";

  static String timeFomart = "HH:mm:ss";
  static String timeDateFormat = "HH:mm dd/MM/yyyy";

  static String locateDatetime2 = "dd/MM/yyyy HH:mm:ss";
  static String locateDatetime = "yyyy/MM/dd HH:mm:ss";

  static DateTime getFirstDateOfMonth() {
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    return firstDayOfMonth;
  }

  static DateTime getLastDateOfMonth() {
    DateTime now = DateTime.now();
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    return lastDayOfMonth;
  }

  static DateTime convertStringToDate(String data, String formatFrom) {
    try {
      return DateFormat(formatFrom).parse(data);
    } catch (e) {
      return DateTime.now();
    }
  }

  static String convertTimeToFormat(TimeOfDay time) {
    return "${time.hour}:${time.minute}";
  }

  static String convertTimeToFormated(
    String data,
    String? formatFrom,
    String? formatTo,
  ) {
    try {
      DateTime dateTime =
          DateFormat(formatFrom ?? TimeUtils.locateDatetime2).parse(data);
      String formattedDate =
          DateFormat(formatTo ?? TimeUtils.dateFormat).format(dateTime);
      return formattedDate;
    } catch (e) {
      return '';
    }
  }

  static String convertDateTimeToFormat(DateTime time, String formatTo) {
    String formattedDate = DateFormat(formatTo).format(time);
    return formattedDate;
  }

  static String getFirstDayOfMonth(DateTime time, String formatTo) {
    DateTime now = time;
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    return convertDateTimeToFormat(firstDayOfMonth, formatTo);
  }

  static String getLastDayOfMonth(DateTime time, String formatTo) {
    DateTime now = time;
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    return convertDateTimeToFormat(lastDayOfMonth, formatTo);
  }

  static String getFirstTimeOfDay() {
    DateTime now = DateTime.now();
    String firstTimeOfDay =
        "${(now.day.toString().length > 1) ? now.day : "0${now.day}"}-"
        "${(now.month.toString().length > 1) ? now.month : "0${now.month}"}-"
        "${now.year} 00:00";
    return firstTimeOfDay;
  }

  static DateTime getFirstDayOfWeek() {
    DateTime now = DateTime.now();
    int currentDay = now.weekday;
    DateTime firstDayOfWeek = now.subtract(Duration(days: currentDay - 1));
    return firstDayOfWeek;
  }

  static String getYesterday(DateTime time, String formatTo) {
    DateTime now = time;
    DateTime yesterday = DateTime(
        now.year, now.month, now.day - 1, now.hour, now.minute, now.second);
    return convertDateTimeToFormat(yesterday, formatTo);
  }

  static String getDateTime(DateTime date, TimeOfDay time) {
    String dateStr = convertDateTimeToFormat(date, "dd/MM/yyyy");
    String timeStr = "${time.hour}:${time.minute}:00";
    return "$dateStr $timeStr";
  }

  static weekday(DateTime date) {
    int index = date.weekday;
    String name = '';
    switch (index) {
      case 1:
        name = 'Th??? hai';
        break;
      case 2:
        name = 'Th??? ba';
        break;
      case 3:
        name = 'Th??? t??';
        break;
      case 4:
        name = 'Th??? n??m';
        break;
      case 5:
        name = 'Th??? s??u';
        break;
      case 6:
        name = 'Th??? b???y';
        break;
      case 7:
        name = 'Ch??? nh???t';
        break;
      default:
        name = '';
        break;
    }
    return name;
  }

  static getMonthTwoLanguage({int? month}) {
    var mMonth = {
      'vi': {
        1: 'Th??ng 1',
        2: 'Th??ng 2',
        3: 'Th??ng 3',
        4: 'Th??ng 4',
        5: 'Th??ng 5',
        6: 'Th??ng 6',
        7: 'Th??ng 7',
        8: 'Th??ng 8',
        9: 'Th??ng 9',
        10: 'Th??ng 10',
        11: 'Th??ng 11',
        12: 'Th??ng 12',
      },
      'en': {
        1: 'January',
        2: 'February',
        3: 'March ',
        4: 'April',
        5: 'May',
        6: 'June',
        7: 'July',
        8: 'August',
        9: 'September',
        10: 'October',
        11: 'November',
        12: 'December',
      },
    };
    return mMonth['vi']![month];
  }

  static DateTime utc({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    DateTime d = DateTime.now();
    return DateTime(year ?? d.year, month ?? d.month, day ?? d.day,
        hour ?? d.hour, minute ?? d.minute, second ?? d.second);
  }

  /*
   * @author TaiDM
   * @date 21-09-2021 08:45 AM
   * @update H??m n??y c?? t??c d???ng so s??nh 2 th???i gian (hour, minute) n???u th???i [date] > [now] => 1;[date] == [now] => 0;[date] < [now] => -1;
   */
  static int compareTimeWithNow({DateTime? date, DateTime? now}) {
    now = now ?? DateTime.now();
    if (date!.hour > now.hour) {
      return 1;
    } else if (date.hour == now.hour) {
      if (date.minute > now.minute) {
        return 1;
      } else if (date.minute == now.minute) {
        return 0;
      } else {
        return -1;
      }
    } else {
      return -1;
    }
  }

  /*
   * @author TaiDM
   * @date 21-09-2021 08:53 AM
   * @update H??m n??y c?? t??c d???ng so s??nh 2 th???i gian (year, month, day) n???u th???i [date] > [now] => 1;[date] == [now] => 0;[date] < [now] => -1;
   */
  static int compareDateWithNow({required DateTime d1, required DateTime d2}) {
    if (d1.year > d2.year) {
      return 1;
    } else if (d1.year == d2.year) {
      if (d1.month > d2.month) {
        return 1;
      } else if (d1.month == d2.month) {
        if (d1.day > d2.day) {
          return 1;
        } else if (d1.day == d2.day) {
          return 0;
        } else {
          return -1;
        }
      } else {
        return -1;
      }
    } else {
      return -1;
    }
  }

  static int compareDateTime({DateTime? date, DateTime? now}) {
    now = now ?? DateTime.now();
    if (date!.year > now.year) {
      return 1;
    } else if (date.year == now.year) {
      if (date.month > now.month) {
        return 1;
      } else if (date.month == now.month) {
        if (date.day > now.day) {
          return 1;
        } else if (date.day == now.day) {
          if (date.hour > now.hour) {
            return 1;
          } else if (date.hour == now.hour) {
            if (date.minute > now.minute) {
              return 1;
            } else if (date.minute == now.minute) {
              return 0;
            } else {
              return -1;
            }
          } else {
            return -1;
          }
        } else {
          return -1;
        }
      } else {
        return -1;
      }
    } else {
      return -1;
    }
  }

  //--------------------- l???y ra c??c ng??y ?????u ti??n v?? cu???i c??ng c???a m???t tu???n (c??ng c?? th??? l???y ???????c c??c ng??y trong tu???n)
  static List<DateTime> getDayOfWeek({DateTime? dateTime}) {
    dateTime = dateTime ?? DateTime.now();
    List<DateTime> dateTimeCheck = [];
    DateTime monday =
        dateTime.subtract(Duration(days: DateTime.now().weekday - 1));
    DateTime sunday = DateTime(monday.year, monday.month, monday.day + 6);
    for (int i = 0; i < 7; i++) {
      dateTimeCheck.add(DateTime(monday.year, monday.month, monday.day + i));
    }

    return dateTimeCheck;
  }
}
