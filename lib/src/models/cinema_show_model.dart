import 'dart:convert';

CinemaShowBuy? cinemaShowModelFromJson(String str) =>
    CinemaShowBuy.fromJson(json.decode(str));

String cinemaShowModelToJson(CinemaShowBuy? data) =>
    json.encode(data!.toJson());

class CinemaShowBuy {
  CinemaShowBuy({
    this.movieRef,
    required this.showId,
    this.title,
    this.date,
    this.time,
    this.duration,
    this.audio,
    this.visualization,
    this.tickets,
    required this.price,
    this.seats,
  });

  String? movieRef;
  String showId;
  String? title;
  String? date;
  String? time;
  int? duration;
  String? audio;
  String? visualization;
  int? tickets;
  String price;
  Map<String, List<int>>? seats;
  factory CinemaShowBuy.fromJson(Map<String, dynamic> json) => CinemaShowBuy(
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
      seats: json["seats"]);

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
        "seats": seats
      };
}
