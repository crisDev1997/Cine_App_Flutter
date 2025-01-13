import 'package:flutter/material.dart';

import '../../models/ticket_model.dart';

class TicketsCard extends StatelessWidget {
  TicketsCard(
      {Key? key,
      required this.title,
      required this.imgURL,
      required this.hour,
      required this.quantity,
      this.tickets})
      : super(key: key);
  String title;
  String imgURL;
  String hour;
  int quantity;
  List<TicketModel>? tickets;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], border: Border.all(color: Colors.black38)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imgURL,
            fit: BoxFit.fitHeight,
            height: 220,
            width: MediaQuery.of(context).size.width * 0.32,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/no.image.jpg',
                fit: BoxFit.fitHeight,
                height: 118,
                width: 118,
              );
            },
          ),
          Container(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Hora: $hour",
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Cantidad adquirida: $quantity",
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 20.0,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(71, 219, 36, 0.7)),
                        onPressed: () {},
                        child: const Center(
                            child: Text(
                          'Ver Entradas',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        )))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
