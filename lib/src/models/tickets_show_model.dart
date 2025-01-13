import 'dart:convert';

import 'package:cine_app/src/models/ticket_model.dart';

TicketsShowModel ticketsShowModelFromJson(String str) =>
    TicketsShowModel.fromJson(json.decode(str));

String ticketsShowModelToJson(TicketsShowModel data) =>
    json.encode(data.toJson());

class TicketsShowModel {
  String showId;
  String title;
  String imgURL;
  String date;
  String hour;
  List<TicketModel> ticketList;
  TicketsShowModel(
      {required this.showId,
      required this.ticketList,
      required this.title,
      required this.imgURL,
      required this.date,
      required this.hour});

  factory TicketsShowModel.fromJson(Map<String, dynamic> json) =>
      TicketsShowModel(
          showId: json["showRef"],
          title: json["title"],
          imgURL: json["imgURL"],
          ticketList: json["ticketList"],
          date: json["date"],
          hour: json["hour"]);

  Map<String, dynamic> toJson() => {
        "showRef": showId,
      };
}
