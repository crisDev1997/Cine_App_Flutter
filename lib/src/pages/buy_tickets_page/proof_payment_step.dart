import 'dart:io';

import 'package:cine_app/src/providers/buy_provider.dart';
import 'package:cine_app/src/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProofPaymentStep extends StatefulWidget {
  ProofPaymentStep({Key? key, required this.proofPayImage}) : super(key: key);
  String proofPayImage;
  @override
  State<ProofPaymentStep> createState() => _ProofPaymentStepState();
}

class _ProofPaymentStepState extends State<ProofPaymentStep> {
  var image = "";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final buyData = context.watch<BuyProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
          child: Text("Monto a Pagar: ${buyData.total}0 Bs"),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
          child: Text(
            "Por favor al momento de realizar la transacción, introduzca la cifra exacta del costo total de las entradas, para realizar la transaccion",
            textScaleFactor: 0.9,
            maxLines: 3,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
          child: Text(
            "NOTA: Actualmente no se cuenta con servicio de reembolso en caso de insuficiencia del monto total",
            textScaleFactor: 0.9,
            maxLines: 2,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
          child: Text(
            "Guarde la captura del deposito y seleccione la imagen del deposito de su almacenamiento para subir el comprobante:",
            textScaleFactor: 0.9,
            maxLines: 3,
          ),
        ),
        isLoading
            ? const CircularProgressIndicator()
            : image.isEmpty
                ? Container(
                    height: 300,
                    width: 300,
                    color: Colors.grey,
                    child: const Center(
                        child: Text("Ninguna imagen seleccionada")),
                  )
                : Image.file(
                    File(image),
                    width: 300,
                    height: 300,
                    fit: BoxFit.fill,
                  ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ElevatedButton(
            child: const Text("Seleccionar imagen de galeria"),
            onPressed: () async {
              final storageService = StorageService();
              setState(() {
                isLoading = true;
              });
              image = await storageService.setImageFile();
              setState(() {
                widget.proofPayImage = image;
              });
              setState(() {
                isLoading = false;
              });
            },
          ),
        )
      ],
    );
  }
}
