import 'dart:convert';

MovieShowsModel? movieShowsModelFromJson(String str) =>
    MovieShowsModel.fromJson(json.decode(str));

String movieShowsModelToJson(MovieShowsModel? data) =>
    json.encode(data!.toJson());

class MovieShowsModel {
  MovieShowsModel({
    required this.movieId,
    required this.ids,
    required this.title,
    required this.imgURL,
    required this.duration,
    required this.date,
    required this.times,
    required this.audios,
    required this.visualizations,
    required this.tickets,
    required this.prices,
    this.rooms,
    this.seats,
  });

  String movieId;
  List<String> ids;
  String title;
  String imgURL;
  int duration;
  String date;
  List<String> times;
  List<String> audios;
  List<String> visualizations;
  List<int> tickets;
  List<String> prices;
  List<String>? rooms;
  List<Map<String, List<int>>?>? seats;

  factory MovieShowsModel.fromJson(Map<String, dynamic> json) =>
      MovieShowsModel(
          movieId: json["movieId"],
          title: json["title"],
          duration: json["duration"],
          imgURL: json["imgURL"],
          date: json["date"],
          ids: json["ids"] == null
              ? []
              : List<String>.from(json["ids"]!.map((x) => x)),
          times: json["times"] == null
              ? []
              : List<String>.from(json["times"]!.map((x) => x)),
          audios: json["audios"] == null
              ? []
              : List<String>.from(json["audios"]!.map((x) => x)),
          visualizations: json["visualizations"] == null
              ? []
              : List<String>.from(json["visualizations"]!.map((x) => x)),
          tickets: json["tickets"] == null
              ? []
              : List<int>.from(json["tickets"]!.map((x) => x)),
          prices: json["prices"] == null
              ? []
              : List<String>.from(json["prices"]!.map((x) => x)),
          seats:
              json["seats"] == null
                  ? []
                  : List<Map<String, List<int>>>.from(
                      json['seats']!.map((x) => x)));

  Map<String, dynamic> toJson() => {
        "movieId": movieId,
        "title": title,
        "duration": duration,
        "imgURL": imgURL,
        "date": date,
        "ids": ids == null ? [] : List<dynamic>.from(ids.map((x) => x)),
        "times": times == null ? [] : List<dynamic>.from(times.map((x) => x)),
        "audios":
            audios == null ? [] : List<dynamic>.from(audios.map((x) => x)),
        "visualizations": visualizations == null
            ? []
            : List<dynamic>.from(visualizations.map((x) => x)),
        "tickets":
            tickets == null ? [] : List<dynamic>.from(tickets.map((x) => x)),
        "prices":
            prices == null ? [] : List<dynamic>.from(prices.map((x) => x)),
        "seats": seats == null
            ? []
            : List<Map<String, List<int>>>.from(seats!.map((x) => x))
      };
}
