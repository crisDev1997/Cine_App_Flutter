import 'dart:convert';

MovieModel movieModelFromJson(String str) =>
    MovieModel.fromJson(json.decode(str));

String movieModelToJson(MovieModel data) => json.encode(data.toJson());

class MovieModel {
  MovieModel({
    required this.id,
    required this.title,
    required this.genre,
    required this.synopsis,
    required this.imgURL,
    required this.releaseDate,
    required this.clasification,
    this.duration,
    this.onBillboard,
    this.comingSoon,
    this.recentlyReleased,
  });

  String id;
  String title;
  String genre;
  String synopsis;
  int? duration;
  String imgURL;
  String releaseDate;
  int clasification;
  bool? onBillboard;
  bool? comingSoon;
  bool? recentlyReleased;

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        id: json["id"],
        title: json["title"],
        genre: json["genre"],
        synopsis: json["synopsis"],
        duration: int.parse(json["duration"].toString()),
        imgURL: json["imgURL"],
        releaseDate: json["releaseDate"],
        clasification: json["clasification"],
        onBillboard: json["onBillboard"],
        comingSoon: json["comingSoon"],
        recentlyReleased: json["recentlyReleased"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "genre": genre,
        "synopsis": synopsis,
        "duration": duration,
        "imgURL": imgURL,
        "dateRelease": releaseDate,
        "clasification": clasification,
        "onBillboard": onBillboard,
        "comingSoon": comingSoon,
        "recentlyReleased": recentlyReleased,
      };
}
