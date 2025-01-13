import 'package:flutter/material.dart';
import 'package:cine_app/src/models/movie_shows_model.dart';
import 'package:cine_app/src/pages/buy_tickets_page/buy_tickets_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CinemaShowList extends StatelessWidget {
  CinemaShowList({
    Key? key,
    required this.movies,
    required this.dateSelected,
    required this.currentDateTime,
    required this.controller,
  }) : super(key: key);
  List<MovieShowsModel> movies;
  DateTime dateSelected;
  ScrollController controller;
  DateTime currentDateTime;
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: movies.length,
      scrollDirection: Axis.vertical,
      controller: controller,
      separatorBuilder: (context, index) => const SizedBox(
        height: 8.0,
      ),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var movie = movies[index];
        return CinemaShowsContainer(
          key: ValueKey(movie.movieId),
          movieRef: movie.movieId,
          ids: movie.ids,
          imgURL: movie.imgURL,
          duration: movie.duration,
          dateSelected: DateUtils.dateOnly(dateSelected),
          title: movie.title,
          currentDateTime: currentDateTime,
          times: movie.times,
          audios: movie.audios,
          visualizations: movie.visualizations,
          prices: movie.prices,
          tickets: movie.tickets,
          seats: movie.seats,
          showSellTickets: (dateSelected
                      .compareTo(DateUtils.dateOnly(currentDateTime)) >
                  0 ||
              dateSelected.compareTo(DateUtils.dateOnly(currentDateTime)) == 0),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class CinemaShowsContainer extends StatefulWidget {
  CinemaShowsContainer(
      {Key? key,
      required this.movieRef,
      required this.ids,
      required this.imgURL,
      required this.title,
      required this.currentDateTime,
      required this.dateSelected,
      required this.times,
      required this.audios,
      required this.duration,
      required this.visualizations,
      required this.prices,
      required this.tickets,
      required this.showSellTickets,
      this.seats,
      this.timesSubtitled,
      this.timesTranslated})
      : super(key: key);

  String movieRef;
  List<String> ids;
  String imgURL;
  String title;
  DateTime dateSelected;
  int duration;
  List<String> times;
  List<String> audios;
  List<String> visualizations;
  List<int> tickets;
  List<String> prices;
  bool showSellTickets;
  List<String>? timesSubtitled;
  List<String>? timesTranslated;
  List<Map<String, List<int>>?>? seats;
  DateTime currentDateTime;
  @override
  State<CinemaShowsContainer> createState() => _CinemaShowsContainerState();
}

class _CinemaShowsContainerState extends State<CinemaShowsContainer> {
  List<String> times1 = [];
  List<String> audios = [];
  List<int> tickets = [];
  List<String> prices = [];
  List<String> visualizations = [];
  List<String> ids = [];
  List<Map<String, List<int>>?>? seats;
  late String timeTicketsAvailable = '';
  late String timesJoined = '';

  @override
  void initState() {
    timesJoined = widget.times.join(' - ');
    timesTicketAvailable(widget.tickets, widget.times);
    super.initState();
  }

  void timesTicketAvailable(List<int> ticketsList, List<String> times) {
    List<String> setTimesAvailable = [];
    List<String> audiosAvailable = [];
    List<String> visualizationsAvailable = [];
    List<int> ticketsAvailable = [];
    List<String> pricesAvailable = [];
    List<String> idsAvailable = [];
    List<Map<String, List<int>>?>? seatsShowsAvailable = [];
    TimeOfDay currentTime = TimeOfDay.fromDateTime(widget.currentDateTime);
    for (var i = 0; i < ticketsList.length; i++) {
      var splitted = times[i].split(":");
      var showTime = int.parse(splitted[0]) * 60 + int.parse(splitted[1]);
      if (ticketsList[i] > 0 &&
          (widget.dateSelected
                      .compareTo(DateUtils.dateOnly(widget.currentDateTime)) >
                  0 ||
              widget.dateSelected.compareTo(
                          DateUtils.dateOnly(widget.currentDateTime)) ==
                      0 &&
                  currentTime.hour * 60 + currentTime.minute <
                      showTime + widget.duration)) {
        setTimesAvailable.add(times[i]);
        audiosAvailable.add(widget.audios[i]);
        visualizationsAvailable.add(widget.visualizations[i]);
        ticketsAvailable.add(widget.tickets[i]);
        pricesAvailable.add(widget.prices[i]);
        seatsShowsAvailable.add(widget.seats?[i]);
        idsAvailable.add(widget.ids[i]);
      }
    }
    setState(() {
      times1 = setTimesAvailable;
      audios = audiosAvailable;
      tickets = ticketsAvailable;
      prices = pricesAvailable;
      visualizations = visualizationsAvailable;
      seats = seatsShowsAvailable;
      timeTicketsAvailable = setTimesAvailable.join(" - ");
      ids = idsAvailable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80,
      decoration: BoxDecoration(
          color: Colors.white54,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(-1, 1),
            )
          ],
          border: Border.all(
              color: Colors.black, width: 1.0, style: BorderStyle.solid)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            widget.imgURL,
            fit: BoxFit.fitHeight,
            height: 220,
            width: MediaQuery.of(context).size.width * 0.32,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/no.image.jpg',
                fit: BoxFit.fitHeight,
                height: 220,
                width: 118,
              );
            },
          ),
          Container(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 190,
                  margin: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                  child: Text(
                    widget.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.clock,
                        size: 16.0,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.40,
                        child: Text(
                          timesJoined,
                          style: const TextStyle(fontSize: 14),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
                /* timesSubtitled != null
                    ? _infoOptional("Subtitulado", timesSubtituledJoined)
                    : const SizedBox(),
                timesTranslated != null
                    ? _infoOptional("Doblado", timesTranslatedJoined)
                    : const SizedBox(), */
                timeTicketsAvailable != '' && widget.showSellTickets
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.checkCircle,
                                color: Colors.green,
                                size: 16.0,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Entradas Disponibles: ",
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.40,
                                    child: Text(
                                      timeTicketsAvailable,
                                      style: const TextStyle(fontSize: 14),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BuyTicketsPage(
                                                movieRef: widget.movieRef,
                                                ids: ids,
                                                title: widget.title,
                                                tickets: tickets,
                                                prices: prices,
                                                times: times1,
                                                duration: widget.duration,
                                                visualizations: visualizations,
                                                imgURL: widget.imgURL,
                                                audios: audios,
                                                date: widget.dateSelected,
                                                seats: seats,
                                              )));
                                },
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size.fromHeight(0.25),
                                    backgroundColor:
                                        const Color.fromRGBO(25, 190, 184, 1),
                                    shape: const RoundedRectangleBorder()),
                                child: Row(
                                  children: const [
                                    FaIcon(
                                      FontAwesomeIcons.checkCircle,
                                      size: 16.0,
                                    ),
                                    SizedBox(
                                      width: 6.0,
                                    ),
                                    Text(
                                      'Comprar entradas',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    )
                                  ],
                                )),
                          )
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
