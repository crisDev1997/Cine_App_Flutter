import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:provider/provider.dart';

import '../../providers/buy_provider.dart';

class PayPalPayPage extends StatefulWidget {
  PayPalPayPage({
    Key? key,
    required this.showId,
    required this.unityPrice,
    required this.quantity,
  }) : super(key: key);

  int quantity;
  double unityPrice;
  String showId;

  @override
  State<PayPalPayPage> createState() => _PayPalPayPageState();
}

class _PayPalPayPageState extends State<PayPalPayPage> {
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
                                  String total =
                                      (buyData.total / 6.93).toStringAsFixed(2);
                                  String unityPrice = (widget.unityPrice / 6.93)
                                      .toStringAsFixed(2);
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
                                                      "price": unityPrice,
                                                      "currency": "USD"
                                                    }
                                                  ],
                                                }
                                              }
                                            ],
                                            note:
                                                "Contact us for any questions on your order.",
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
