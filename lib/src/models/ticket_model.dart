import 'dart:convert';

TicketModel ticketModelFromJson(String str) =>
    TicketModel.fromJson(json.decode(str));

String ticketModelToJson(TicketModel data) => json.encode(data.toJson());

class TicketModel {
  String id;
  String codQR;
  String showId;
  String movieId;
  String userId;
  String title;
  String imgURL;
  String date;
  String hour;
  String state;
  String? room;
  String? seatNumber;
  DateTime? expireDate;

  TicketModel({
    required this.id,
    required this.codQR,
    required this.showId,
    required this.movieId,
    required this.userId,
    required this.title,
    required this.imgURL,
    required this.date,
    required this.hour,
    required this.state,
    this.room,
    this.seatNumber,
    this.expireDate,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
        id: json["id"],
        codQR: json["codQR"],
        showId: json["showId"],
        movieId: json["movieId"],
        userId: json["userId"],
        title: json["title"],
        imgURL: json["imgURL"],
        date: json["date"],
        hour: json["hour"],
        state: json["state"],
        room: json["room"],
        seatNumber: json["seatNumber"],
        expireDate: json["expireDate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codQR": codQR,
        "showRef": showId,
        "movieRef": movieId,
        "userRef": userId,
        "title": title,
        "imageURL": imgURL,
        "date": date,
        "hour": hour,
        "state": state,
        "room": room,
        "seatNumber": seatNumber,
        "expireDate": expireDate,
      };
}
