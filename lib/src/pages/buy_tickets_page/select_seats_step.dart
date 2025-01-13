import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/buy_provider.dart';

class SelectSeatsStep extends StatefulWidget {
  SelectSeatsStep(
      {Key? key, required this.showId, this.seats, required this.callback})
      : super(key: key);
  String showId;
  VoidCallback callback;
  Map<String, List<int>>? seats;

  @override
  State<SelectSeatsStep> createState() => _SelectSeatsStepState();
}

class _SelectSeatsStepState extends State<SelectSeatsStep> {
  Map<String, List<int>> selectedSeats = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final buyData = context.watch<BuyProvider>();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Seleccione las casillas verdes, para escoger los asientos ",
              style: TextStyle(fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Cantidad de asientos para reservar: ${buyData.numberSeats} ",
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Deslize hacia los lados para ver todos los asientos: ",
              style: TextStyle(fontSize: 14),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              direction: Axis.vertical,
              children: widget.seats!.entries.map((entry) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Wrap(
                      children: List.generate(entry.value.length, (index) {
                        final value = entry.value[index];
                        if (value == 0) {
                          return Container(
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.all(2.0),
                          );
                        }

                        return GestureDetector(
                          onTap: () {
                            int modIntArray = 1;
                            int i = 0;
                            int zeroCount = 0;
                            while (i < index) {
                              if (entry.value[i] == 0) {
                                zeroCount++;
                              }
                              i++;
                            }
                            modIntArray -= zeroCount;
                            setState(() {
                              String key = entry.key;

                              if (entry.value[index] == 4) {
                                entry.value[index] = 1;
                                selectedSeats[key] ??= [];
                                selectedSeats[key]?.remove(index + modIntArray);
                                buyData.setNumberSeats(buyData.numberSeats + 1);
                                if (selectedSeats[key]!.isEmpty) {
                                  selectedSeats.remove(key);
                                }
                              } else if (buyData.numberSeats > 0 &&
                                  entry.value[index] == 1) {
                                entry.value[index] = 4;
                                selectedSeats[key] ??= [];
                                selectedSeats[key]!.add(index + modIntArray);
                                buyData.setNumberSeats(buyData.numberSeats - 1);
                                if (buyData.numberSeats == 0) {}
                              }
                            });
                          },
                          child: Container(
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              color: value == 4
                                  ? Colors.blueAccent
                                  : value == 3
                                      ? Colors.red
                                      : value == 2
                                          ? Colors.orange[800]
                                          : Colors.green[400],
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0, right: 1.0),
                      child: Text(
                        entry.key,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: Text("Pantalla"),
            ),
          ),
        ],
      ),
    );
  }
}
