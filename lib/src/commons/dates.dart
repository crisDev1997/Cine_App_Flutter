import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter, unused_import
/* import 'package:timezone/browser.dart';
import 'package:timezone/standalone.dart' as tz; */

class Dates {
  Dates(this.date);
  List<String> datesFormated = [];
  late DateTime date;
  Map<String, String> days = {
    "Monday": "Lunes",
    "Tuesday": "Martes",
    "Wednesday": "Miércoles",
    "Thursday": "Jueves",
    "Friday": "Viernes",
    "Saturday": "Sábado",
    "Sunday": "Domingo"
  };

  Map<String, String> months = {
    "1": "Enero",
    "2": "Febrero",
    "3": "Marzo",
    "4": "Abril",
    "5": "Mayo",
    "6": "Junio",
    "7": "Julio",
    "8": "Agosto",
    "9": "Septiembre",
    "10": "Octubre",
    "11": "Noviembre",
    "12": "Diciembre",
  };
  String? getDay(String day) {
    return days[day];
  }

  String? getMonth(String month) {
    return months[month];
  }

  String getDateSubtitle(DateTime date) {
    var day = getDay(DateFormat('EEEE').format(date).toString());
    var datE = DateFormat('d').format(date).toString();
    var month = getMonth(DateFormat('M').format(date).toString());
    return "$day $datE de $month";
  }

  List<dynamic> getWeek() {
    List<dynamic> days = [];
    for (var i = -2; i < 5; i++) {
      var newDate = DateTime(date.year, date.month, date.day + i);
      var day = getDay(DateFormat('EEEE').format(newDate).toString());
      var datE = DateFormat('d').format(newDate).toString();
      var month = getMonth(DateFormat('M').format(newDate).toString());
      var dateSubtitle = "$day $datE de $month";
      var dateFormated =
          "${newDate.day.toString()}-${newDate.month.toString().padLeft(2, '0')}-${newDate.year.toString().padLeft(2, '0')}";
      var aux = {
        "day": day,
        "date": datE,
        "dateSubtitle": dateSubtitle,
        "dateFormated": dateFormated
      };
      datesFormated.add(aux['dateFormated'] ?? '');
      days.add(aux);
    }

    return days;
  }

  static String castDateTimeToDateFormated(DateTime dateTime) {
    String dateFormated =
        "${dateTime.day.toString()}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year.toString().padLeft(2, '0')}";
    return dateFormated;
  }

  List<String> getDatesFormated() {
    return datesFormated;
  }

  /* Future<TZDateTime> getCurrentDate(DateTime currentDate) async {
    var laPazTimezone = tz.getLocation('America/La_Paz');
    var now = tz.TZDateTime.from(currentDate, laPazTimezone);
    return now;
  } */
  static Future<String> getCurrentDateAPI() async {
    var response = await http
        .get(Uri.parse("http://worldtimeapi.org/api/timezone/America/La_Paz"));
    if (response.statusCode.toString() == "200") {
      var res = await jsonDecode(response.body);
      return res["datetime"].toString();
    }
    return '';
  }
}
