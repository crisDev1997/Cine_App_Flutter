import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cine_app/src/pages/buy_tickets_page/proof_payment_step.dart';
import 'package:cine_app/src/pages/buy_tickets_page/qr_code_step.dart';
import 'package:cine_app/src/pages/buy_tickets_page/select_seats_step.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/buy_provider.dart';

class PayWithSeatsPage extends StatefulWidget {
  PayWithSeatsPage(
      {Key? key, required this.showId, required this.callback, this.seats})
      : super(key: key);
  String showId;
  final VoidCallback callback;
  Map<String, List<int>>? seats;

  @override
  State<PayWithSeatsPage> createState() => _PayWithSeatsPageState();
}

class _PayWithSeatsPageState extends State<PayWithSeatsPage> {
  int currentStep = 0;
  int numberSeats = 0;
  String proofPayImage = '';
  String errorMessage = '';
  continueStep() {
    if (currentStep == 0 && numberSeats == 0) {
      setState(() {
        currentStep++;
      });
    } else if (currentStep == 1) {
      setState(() {
        currentStep++;
      });
    } else if (currentStep == 2 && proofPayImage.isNotEmpty) {
      setState(() {
        currentStep++;
      });
    }
  }

  cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  onStepTapped(int value) {
    if (value == 0 || value == 1) {
      setState(() {
        currentStep = value;
      });
    }
  }

  Widget controlsBuilder(context, details) {
    if (currentStep == 2) {
      return Row(
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                bool isProcessed = true;
                print(proofPayImage);
                if (proofPayImage.isEmpty) {
                  setState(() {
                    errorMessage = "No selecciono ninguna imagen!";
                  });
                } else {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        Future.delayed(const Duration(seconds: 5), () {
                          Navigator.of(context).pop();
                        });
                        return const Center(child: CircularProgressIndicator());
                      }).then((value) {
                    if (isProcessed) {
                      AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.topSlide,
                              showCloseIcon: true,
                              title: "Transaccion completa!",
                              desc:
                                  "Se ha enviado correctamente los datos de compra")
                          .show()
                          .then((value) {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      });
                    }
                  });
                }
              },
              child: const Text(
                "Enviar Pago",
                style: TextStyle(fontSize: 18),
              )),
          const SizedBox(
            width: 20,
          ),
          ElevatedButton(
              onPressed: details.onStepCancel, child: const Text("Atras")),
        ],
      );
    } else if (currentStep == 1) {
      return Row(
        children: [
          ElevatedButton(
              onPressed: details.onStepContinue, child: const Text("Listo")),
          const SizedBox(
            width: 20,
          ),
          ElevatedButton(
              onPressed: details.onStepCancel, child: const Text("Atras")),
        ],
      );
    } else {
      return Row(
        children: [
          ElevatedButton(
              onPressed: details.onStepContinue, child: const Text("Listo")),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final buyData = context.watch<BuyProvider>();
    numberSeats = buyData.numberSeats;
    proofPayImage = buyData.proofPay;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(237, 245, 253, 1),
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 10.0, bottom: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(40.0)),
                            color: Colors.white60,
                            border:
                                Border.all(color: Colors.black, width: 2.0)),
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
              Expanded(
                child: Stepper(
                    currentStep: currentStep,
                    onStepContinue: continueStep,
                    onStepCancel: cancelStep,
                    controlsBuilder: controlsBuilder,
                    onStepTapped: onStepTapped,
                    type: StepperType.vertical,
                    steps: [
                      Step(
                        title: const Text("Paso 1 Reservar Asientos"),
                        isActive: currentStep == 0,
                        state: currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled,
                        content: widget.seats != null
                            ? SelectSeatsStep(
                                showId: widget.showId,
                                callback: widget.callback,
                                seats: widget.seats,
                              )
                            : Container(),
                      ),
                      Step(
                          title: const Text(
                              "Paso 2 Descarga el QR para el deposito"),
                          isActive: currentStep == 1,
                          state: currentStep >= 1
                              ? StepState.complete
                              : StepState.disabled,
                          content: const QRCodeStep()),
                      Step(
                          title: const Text(
                              "Paso 3 Subir imagen de comprobante de deposito"),
                          isActive: currentStep == 2,
                          state: currentStep >= 2
                              ? StepState.complete
                              : StepState.disabled,
                          content: Column(
                            children: [
                              ProofPaymentStep(
                                proofPayImage: proofPayImage,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  errorMessage,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              )
                            ],
                          )),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
