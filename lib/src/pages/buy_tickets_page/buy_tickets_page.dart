import 'package:cine_app/src/commons/dates.dart';
import 'package:cine_app/src/commons/validators.dart';
import 'package:cine_app/src/models/cinema_show_model.dart';
import 'package:cine_app/src/widgets/custom_textfield1.dart';
import 'package:flutter/material.dart';

class BuyTicketsPage extends StatefulWidget {
  BuyTicketsPage(
      {Key? key,
      required this.movieRef,
      required this.ids,
      required this.imgURL,
      required this.title,
      required this.tickets,
      required this.audios,
      required this.duration,
      required this.date,
      required this.prices,
      required this.times,
      required this.visualizations})
      : super(key: key);
  String movieRef;
  List<String> ids;
  String imgURL;
  String title;
  DateTime date;
  int duration;
  List<String> times;
  List<String> audios;
  List<String> visualizations;
  List<int> tickets;
  List<String> prices;
  @override
  State<BuyTicketsPage> createState() => _BuyTicketsPageState();
}

class _BuyTicketsPageState extends State<BuyTicketsPage> {
  late double total;
  late String selectedValue;
  late CinemaShowModel cinemaShowSelected;
  late String textFormatedDuration;
  final TextEditingController _doc = TextEditingController(),
      _invoiceName = TextEditingController();
  late int counter;
  final _globalFormKey = GlobalKey<FormState>();
  final Validators _validators = Validators();
  @override
  void initState() {
    counter = 1;
    selectedValue = widget.times[0];
    textFormatedDuration = widget.duration % 60 > 0
        ? "${(widget.duration / 60).floor()} hora(s) y ${widget.duration % 60} minutos"
        : "${(widget.duration / 60).floor()} hora(s)";
    cinemaShowSelected = CinemaShowModel(
        movieRef: widget.movieRef,
        showId: widget.ids[0],
        title: widget.title,
        audio: widget.audios[0],
        date: Dates.castDateTimeToDateFormated(widget.date),
        visualization: widget.visualizations[0],
        price: widget.prices[0],
        duration: widget.duration,
        tickets: widget.tickets[0],
        time: widget.times[0]);

    total = double.parse(cinemaShowSelected.price) * counter;
    super.initState();
  }

  bool _testInputs() => _globalFormKey.currentState!.validate();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromRGBO(237, 245, 253, 1),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin:
                      const EdgeInsets.only(left: 10.0, top: 15.0, right: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 1.0)),
                    width: 50.0,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 30,
                        )),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: const Text(
                    'ADQUIRIR ENTRADAS',
                    style:
                        TextStyle(fontSize: 26.0, fontWeight: FontWeight.w300),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Image.network(
                    widget.imgURL,
                    height: 150,
                    width: 120,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/no_image.jpg',
                        height: 160,
                        width: 120,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      widget.title.toUpperCase(),
                      maxLines: 3,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 50.0),
                    child: Text(
                      "Seleccione el horario: ",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  DropdownButton<String>(
                    value: selectedValue,
                    key: ValueKey(cinemaShowSelected.showId),
                    items: widget.times.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      int index = widget.times.indexWhere((
                        String element,
                      ) =>
                          element == newValue);
                      setState(() {
                        selectedValue = widget.times[index];
                        cinemaShowSelected = CinemaShowModel(
                            movieRef: widget.movieRef,
                            showId: widget.ids[index],
                            title: widget.title,
                            audio: widget.audios[index],
                            date: Dates.castDateTimeToDateFormated(widget.date),
                            visualization: widget.visualizations[index],
                            price: widget.prices[index],
                            duration: widget.duration,
                            tickets: widget.tickets[index],
                            time: widget.times[index]);
                        total =
                            double.parse(cinemaShowSelected.price) * counter;
                      });
                    },
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              child: Text(
                "INFORMACIÓN DE LA FUNCIÓN",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, top: 10.0, bottom: 10.0, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "Título de la película: ${widget.title}",
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Audio: ${cinemaShowSelected.audio}",
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          "Visualización: ${cinemaShowSelected.visualization}",
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Fecha: ${cinemaShowSelected.date}",
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          "  Hora: ${cinemaShowSelected.time}",
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "Duración: $textFormatedDuration",
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      "Precio por entrada: ${cinemaShowSelected.price} Bs.",
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Divider(
                      color: Colors.grey,
                      height: 2,
                      thickness: 2,
                      indent: 0,
                      endIndent: 0,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              child: Text(
                "DATOS PARA FACTURA",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    left: 25.0, top: 10.0, bottom: 10.0, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Rellene los siguientes campos: ",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Form(
                        key: _globalFormKey,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField1(
                                  controller: _doc,
                                  inputHintText: "NIT/Carnet",
                                  inputType: TextInputType.number,
                                  validator: _validators.emptyFieldValidator,
                                  width: 200),
                              CustomTextField1(
                                  controller: _invoiceName,
                                  inputHintText: "Nombre para la factura",
                                  validator: _validators.emptyFieldValidator,
                                  width: 400),
                            ],
                          ),
                        )),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10.0, right: 30.0),
                          child: Text(
                            "Adquirir Entradas:  ",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                        Container(
                          height: 50.0,
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Colors.blueAccent),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 30,
                                height: 49,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                      )),
                                      elevation: 0,
                                      padding: const EdgeInsets.all(4.0),
                                      backgroundColor: Colors.transparent),
                                  onPressed: () {
                                    setState(() {
                                      counter = counter == 1 ? 1 : counter - 1;
                                      total = counter *
                                          double.parse(
                                              cinemaShowSelected.price);
                                    });
                                  },
                                  child: const Center(
                                      child: Text(
                                    "-",
                                    style: TextStyle(fontSize: 30),
                                  )),
                                ),
                              ),
                              Text(
                                counter.toString(),
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              SizedBox(
                                width: 30,
                                height: 49,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                      )),
                                      elevation: 0,
                                      padding: const EdgeInsets.all(4.0),
                                      backgroundColor: Colors.transparent),
                                  onPressed: () {
                                    setState(() {
                                      counter = counter + 1;
                                      total = counter *
                                          double.parse(
                                              cinemaShowSelected.price);
                                    });
                                  },
                                  child: const Center(
                                      child: Text(
                                    "+",
                                    style: TextStyle(fontSize: 18),
                                  )),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                      child: Divider(
                        color: Colors.grey,
                        height: 2,
                        thickness: 2,
                        indent: 0,
                        endIndent: 0,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "DETALLE DE COMPRA",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("x$counter Entrada(s)",
                            style: const TextStyle(fontSize: 14.0))
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child:
                              Text("Total:", style: TextStyle(fontSize: 14.0)),
                        ),
                        Text(
                          "$total Bs.",
                          style: const TextStyle(fontSize: 14.0),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20.0),
                      color: Colors.green[300],
                      child: ElevatedButton(
                          onPressed: () {
                            if (_testInputs()) {
                              //TODO: Verificar la disponibilidad de entradas para esta funcion dependiendo la cantidad de entradas
                              //TODO: Si hay entradas disponibles reservar temporalmente por un tiempo de 1 min
                              //TODO: Crear instancia de GooglePay o PayPal con el monto total
                              //TODO: Verificar si el pago ha sido transferido correctamente!
                              //TODO: Mandar a generar la entradas virtuales
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(),
                              backgroundColor: Colors.transparent,
                              elevation: 0),
                          child: const Center(
                            child: Text(
                              "Pagar Entradas",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          )),
                    ),
                  ],
                )),
          ],
        ),
      ),
    ));
  }
}
