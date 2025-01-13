import 'dart:convert';

ShowModel showModelFromJson(String str) => ShowModel.fromJson(json.decode(str));
String showModelToJson(ShowModel data) => json.encode(data.toJson());

class ShowModel {
  ShowModel({
    required this.id,
    required this.movieId,
    required this.title,
    required this.imgURL,
    required this.audio,
    required this.duration,
    required this.visualization,
    required this.date,
    required this.hour,
    required this.endTime,
    required this.tickets,
    required this.room,
    required this.price,
    this.seats,
  });

  String id;
  String movieId;
  String title;
  String imgURL;
  String audio;
  int duration;
  String visualization;
  String date;
  String hour;
  DateTime endTime;
  int tickets;
  String? room;
  String price;
  Map<String, List<int>>? seats;

  factory ShowModel.fromJson(Map<String, dynamic> json) {
    return ShowModel(
        id: json["id"],
        movieId: json["movieRef"].id.toString(),
        title: json["title"],
        imgURL: json["imgURL"],
        audio: json["audio"],
        visualization: json["visualization"],
        date: json["date"],
        hour: json["hour"],
        duration: json['duration'],
        endTime:
            DateTime.fromMillisecondsSinceEpoch(json["endTime"].seconds * 1000),
        tickets: int.parse(json["tickets"].toString()),
        room: json["room"],
        price: json["price"].toString(),
        seats: json["seats"] == null
            ? null
            : Map.fromEntries(Map<String, List<dynamic>>.from(json["seats"])
                    .entries
                    .toList()
                  ..sort((a, b) => a.key.compareTo(b.key)))
                .map((key, value) => MapEntry(key, value.cast<int>())));
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "movieRef": movieId,
        "title": title,
        "imgURL": imgURL,
        "audio": audio,
        "duration": duration,
        "visualization": visualization,
        "date": date,
        "hour": hour,
        "endTime": endTime,
        "tickets": tickets,
        "room": room,
        "price": price,
        "seats": seats
      };
}
