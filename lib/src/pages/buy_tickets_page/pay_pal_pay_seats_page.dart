import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:provider/provider.dart';

import '../../providers/buy_provider.dart';

class PayPalPaySeatsPage extends StatefulWidget {
  PayPalPaySeatsPage(
      {Key? key,
      required this.showId,
      required this.seats,
      required this.unityPrice,
      required this.quantity,
      required this.callback})
      : super(key: key);
  Map<String, List<int>> seats;
  int quantity;
  String showId;
  double unityPrice;
  final VoidCallback callback;
  @override
  State<PayPalPaySeatsPage> createState() => _PayPalPaySeatsPageState();
}

class _PayPalPaySeatsPageState extends State<PayPalPaySeatsPage> {
  Map<String, List<int>> selectedSeats = {};
  @override
  Widget build(BuildContext context) {
    final buyData = context.watch<BuyProvider>();
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color.fromRGBO(237, 245, 253, 1),
            body: Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 20.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding:
                              const EdgeInsets.only(left: 10.0, bottom: 20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(40.0)),
                                      color: Colors.white60,
                                      border: Border.all(
                                          color: Colors.black, width: 2.0)),
                                  child: IconButton(
                                    icon: const Icon(Icons.arrow_back),
                                    onPressed: () async {
                                      setState(() {
                                        widget.seats = {};
                                      });
                                      widget.callback();
                                      Navigator.pop(context);
                                    },
                                  )),
                              Container(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: const Text(
                                  "Pago de Entradas",
                                  style: TextStyle(fontSize: 24.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Seleccione las casillas verdes, para escoger los asientos ",
                            maxLines: 2,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "NOTA: Deslize hacia los lados para ver todos los asientos ",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Cantidad de asientos para seleccionar: ${buyData.numberSeats} ",
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            direction: Axis.vertical,
                            children: widget.seats.entries.map((entry) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Wrap(
                                    children: List.generate(entry.value.length,
                                        (index) {
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
                                              selectedSeats[key]
                                                  ?.remove(index + modIntArray);
                                              buyData.setNumberSeats(
                                                  buyData.numberSeats + 1);
                                              if (selectedSeats[key]!.isEmpty) {
                                                selectedSeats.remove(key);
                                              }
                                            } else if (buyData.numberSeats >
                                                    0 &&
                                                entry.value[index] == 1) {
                                              entry.value[index] = 4;
                                              selectedSeats[key] ??= [];
                                              selectedSeats[key]!
                                                  .add(index + modIntArray);
                                              buyData.setNumberSeats(
                                                  buyData.numberSeats - 1);
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
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
                                    padding: const EdgeInsets.only(
                                        top: 2.0, right: 1.0),
                                    child: Text(
                                      entry.key,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
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
                          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          child: Center(
                            child: Text("Pantalla"),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 5),
                          child: Text(
                            'Informacion de compra',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 5),
                          child: Text('Carnet o NIT: ${buyData.nitCI}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                              'Nombre para factura: ${buyData.invoiceName}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                              'Cantidad de Entradas que se va adquirir: ${widget.quantity}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                              'Monto total por las entradas: ${buyData.total}0 Bs'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: ElevatedButton(
                                onPressed: () {
                                  print(
                                      'precio de unidad en bs: ${widget.unityPrice}');
                                  String total =
                                      ((widget.unityPrice * widget.quantity) /
                                              6.95)
                                          .toStringAsFixed(2);
                                  String unityPrice = (widget.unityPrice / 6.95)
                                      .round()
                                      .toStringAsFixed(2);
                                  print('precio total en dolares: $total');
                                  print(
                                      'precio de unidad en dolares: $unityPrice');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UsePaypal(
                                            sandboxMode: true,
                                            clientId:
                                                "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
                                            secretKey:
                                                "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
                                            returnURL:
                                                "https://samplesite.com/return",
                                            cancelURL:
                                                "https://samplesite.com/cancel",
                                            transactions: [
                                              {
                                                "amount": {
                                                  "total": total,
                                                  "currency": "USD",
                                                  "details": {
                                                    "subtotal": total,
                                                    "shipping": '0',
                                                    "shipping_discount": 0
                                                  }
                                                },
                                                "description":
                                                    "The payment transaction description.",
                                                // "payment_options": {
                                                //   "allowed_payment_method":
                                                //       "INSTANT_FUNDING_SOURCE"
                                                // },
                                                "item_list": {
                                                  "items": [
                                                    {
                                                      "name":
                                                          "Entradas de cine",
                                                      "quantity":
                                                          widget.quantity,
                                                      "price": "0",
                                                      "currency": "USD"
                                                    }
                                                  ],
                                                }
                                              }
                                            ],
                                            note:
                                                "Contacte con nosotros si tiene alguna duda.",
                                            onSuccess: (Map params) async {
                                              print("onSuccess: $params");
                                            },
                                            onError: (error) {
                                              print("onError: $error");
                                            },
                                            onCancel: (params) {
                                              print('cancelled: $params');
                                            }),
                                      ));
                                },
                                child:
                                    const Text('Pagar Entradas con Pay Pal')),
                          ),
                        ),
                      ]),
                ))));
  }
}
