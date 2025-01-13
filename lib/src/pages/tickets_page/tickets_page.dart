import 'package:cine_app/src/bd_test.dart';
import 'package:cine_app/src/commons/dates.dart';
import 'package:flutter/material.dart';

import '../../models/tickets_show_model.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({Key? key}) : super(key: key);

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  late String dateCompleteSubtitle = "";
  @override
  void initState() {
    super.initState();
    DateTime date = DateTime.now();
    Dates d = Dates(date);
    dateCompleteSubtitle = d.getDateSubtitle(date);
  }

  @override
  Widget build(BuildContext context) {
    var testData = TestData();
    return FutureBuilder(
        future: testData.simulateTickets(),
        builder: ((context,
            AsyncSnapshot<Map<String, List<TicketsShowModel>>> snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 20.0),
                    child: Text(
                      "ENTRADAS: ",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: ((context, index) {
                          final key = snapshot.data!.keys.elementAt(index);
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              child: Text(key),
                            ),
                          );
                        })),
                  )
                ],
              ),
            );
          }
          return Container(
              child: const Center(
            child: Text("Aqui se muestran las entradas"),
          ));
        }));
  }
}
