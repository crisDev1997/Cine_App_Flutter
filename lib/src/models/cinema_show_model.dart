import 'dart:convert';

CinemaShowModel? cinemaShowModelFromJson(String str) =>
    CinemaShowModel.fromJson(json.decode(str));

String cinemaShowModelToJson(CinemaShowModel? data) =>
    json.encode(data!.toJson());

class CinemaShowModel {
  CinemaShowModel({
    this.movieRef,
    this.showId,
    this.title,
    this.date,
    this.time,
    this.duration,
    this.audio,
    this.visualization,
    this.tickets,
    required this.price,
  });

  String? movieRef;
  String? showId;
  String? title;
  String? date;
  String? time;
  int? duration;
  String? audio;
  String? visualization;
  int? tickets;
  String price;

  factory CinemaShowModel.fromJson(Map<String, dynamic> json) =>
      CinemaShowModel(
        movieRef: json["movieRef"],
        showId: json["showId"],
        title: json["title"],
        date: json["date"],
        duration: json["duration"],
        time: json["time"],
        audio: json["audio"],
        visualization: json["visualization"],
        tickets: json["tickets"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "movieRef": movieRef,
        "showId": showId,
        "title": title,
        "date": date,
        "time": time,
        "duration": duration,
        "audio": audio,
        "visualization": visualization,
        "tickets": tickets,
        "price": price,
      };
}
