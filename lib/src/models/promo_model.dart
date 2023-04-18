import 'dart:convert';

PromoModel promoModelFromJson(String str) =>
    PromoModel.fromJson(json.decode(str));

String promoModelToJson(PromoModel data) => json.encode(data.toJson());

class PromoModel {
  PromoModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.imgURL,
    this.expireDate,
    this.items,
    required this.price,
  });

  String id;
  String name;
  String desc;
  String imgURL;
  String? expireDate;
  String? items;
  String? price;

  factory PromoModel.fromJson(Map<String, dynamic> json) => PromoModel(
        id: json["id"],
        name: json["name"],
        desc: json["desc"],
        imgURL: json["imgURL"],
        expireDate: json["expireDate"],
        items: json["items"],
        price: json["price"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "desc": desc,
        "imgURL": imgURL,
        "expireDate": expireDate,
        "items": items,
        "price": price,
      };
}
