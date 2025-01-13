import 'package:cine_app/src/services/storage_service.dart';
import 'package:flutter/material.dart';

class QRCodeStep extends StatelessWidget {
  const QRCodeStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StorageService storageService = StorageService();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
          child: Text(
            "El pago por las entradas adquiridas será a través de un deposito del monto total, puede descargar la imagen o sacar captura de la pantalla del codigo QR para utilizar para el deposito y luego pagar a traves de su aplicacion de banca movil.",
            textScaleFactor: 0.9,
            maxLines: 5,
          ),
        ),
        FutureBuilder(
            future: storageService.getImageFromURL("files", "qr_pago.jpeg"),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.network(
                          snapshot.data,
                          width: 300,
                          height: 300,
                          fit: BoxFit.fill,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: ElevatedButton(
                        onPressed: () {
                          storageService
                              .downloadImageFileByRef("files/qr_pago.jpeg");
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[400]),
                        child: const Text('Descargar Imagen'),
                      ),
                    )
                  ],
                );
              } else {
                return Container();
              }
            }),
      ],
    );
  }
}
