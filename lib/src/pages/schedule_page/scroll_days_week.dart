import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScrollDaysWeek extends StatefulWidget {
  ScrollDaysWeek({
    Key? key,
    required this.days,
    required this.daySelected,
    required this.selectDay,
  }) : super(key: key);
  List<dynamic> days;
  String daySelected;
  Function selectDay;
  @override
  State<ScrollDaysWeek> createState() => _ScrollDaysWeekState();
}

class _ScrollDaysWeekState extends State<ScrollDaysWeek> {
  List<bool> days = [];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, _) => const SizedBox(
          width: 6.0,
        ),
        itemCount: widget.days.length,
        itemBuilder: (context, index) {
          var day = widget.days[index];
          if (widget.daySelected == day["date"]) {
            days.add(true);
          } else {
            days.add(false);
          }
          String daySubtitle = day["dateSubtitle"];
          DateFormat format = DateFormat('dd-MM-yyyy HH:mm');
          DateTime dateTime = format.parse('${day['dateFormated']} 0:00:00');
          return DayContainer(
              day: day["day"],
              date: day["date"],
              selected: days[index],
              callback: () {
                selectDay(index);

                widget.selectDay.call(
                    day["date"], daySubtitle, day["dateFormated"], dateTime);
              },
              index: index);
        },
      ),
    );
  }

  void selectDay(int index) {
    setState(() {
      days = days.map((e) => false).toList();
      days[index] = true;
    });
  }
}

class DayContainer extends StatelessWidget {
  DayContainer(
      {Key? key,
      required this.day,
      required this.date,
      this.selected = false,
      required this.callback,
      required this.index})
      : super(key: key);
  String day;
  String date;
  int index;
  bool selected;
  VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback.call();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        height: 70,
        width: 70,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
            color: selected
                ? const Color.fromRGBO(64, 23, 203, 1)
                : const Color.fromRGBO(237, 245, 253, 1)),
        child: Column(children: [
          Text(
            day,
            style: selected
                ? const TextStyle(fontSize: 14, color: Colors.white)
                : const TextStyle(fontSize: 14),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            date,
            style: selected
                ? const TextStyle(fontSize: 20, color: Colors.white)
                : const TextStyle(fontSize: 20),
          )
        ]),
      ),
    );
  }
}
