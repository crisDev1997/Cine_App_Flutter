import 'package:cine_app/src/models/movie_shows_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:timezone/standalone.dart' as tz;
import '../models/show_model.dart';

class ShowService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<MovieShowsModel>> orderByMovie(List<ShowModel> shows) async {
    List<MovieShowsModel> listMoviesShows = [];
    Map<String, MovieShowsModel> mapMoviesShows = {};
    for (var element in shows) {
      var movieId = element.movieId;
      if (mapMoviesShows.containsKey(movieId)) {
        MovieShowsModel movieExist = mapMoviesShows[movieId] ??
            MovieShowsModel(
                movieId: "movieId",
                ids: [],
                title: "title",
                imgURL: "imgURL",
                duration: 13,
                date: "date",
                times: [],
                audios: [],
                visualizations: [],
                tickets: [],
                prices: [],
                seats: []);
        movieExist.ids.add(element.id);
        movieExist.audios.add(element.audio);
        movieExist.times.add(element.hour);
        movieExist.visualizations.add(element.visualization);
        movieExist.tickets.add(element.tickets);
        movieExist.prices.add(element.price);
        movieExist.seats?.add(element.seats);
      } else {
        var newElement = MovieShowsModel(
            movieId: element.movieId,
            ids: [element.id],
            title: element.title,
            imgURL: element.imgURL,
            duration: element.duration,
            date: element.date,
            times: [element.hour],
            audios: [element.audio],
            visualizations: [element.visualization],
            tickets: [element.tickets],
            prices: [element.price]);
        if (element.seats != null) {
          newElement.seats = [element.seats];
        }
        mapMoviesShows[movieId] = newElement;
      }
    }
    listMoviesShows = mapMoviesShows.values.toList();
    return listMoviesShows;
  }

  Future<List<MovieShowsModel>?> getShowsByDate(String date) async {
    try {
      CollectionReference movieRef = _firestore.collection('shows');
      QuerySnapshot snapshot =
          await movieRef.where('date', isEqualTo: date).get();
      List<MovieShowsModel> listMoviesShows = [];
      List<ShowModel>? shows = [];
      shows = snapshot.docs
          .map((doc) {
            var data = doc.data() as Map<String, dynamic>;
            if (data.keys.contains("id") &&
                data.keys.contains("hour") &&
                data.keys.contains("movieRef") &&
                data.keys.contains("price") &&
                data.keys.contains("audio") &&
                data.keys.contains("date") &&
                data.keys.contains("audio") &&
                data.keys.contains("imgURL") &&
                data.keys.contains("title") &&
                data.keys.contains("endTime")) {
              return ShowModel.fromJson(data);
            }
            return null;
          })
          .whereType<ShowModel>()
          .toList();

      if (shows.isEmpty) {
        return null;
      }
      listMoviesShows = await orderByMovie(shows);
      return listMoviesShows;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  Future<Map<String, List<int>>?> getSeats(String showId) async {
    try {
      CollectionReference movieRef = _firestore.collection('shows');
      DocumentSnapshot snapshot = await movieRef.doc(showId).get();
      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;
        if (data.keys.contains("seats")) {
          Map<String, List<int>> result = Map.fromEntries(
                  Map<String, List<dynamic>>.from(data["seats"])
                      .entries
                      .toList()
                    ..sort((a, b) => a.key.compareTo(b.key)))
              .map((key, value) => MapEntry(key, value.cast<int>()));

          return result;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> checkTicketsAndSeatsIfAvailable(
      String showId, Map<String, List> seats, int numberSeats) async {
    try {
      bool seatsNotAvailable = false;
      bool ticketsNotAvailable = false;
      await tz.initializeTimeZone();
      var venezuela = tz.getLocation('America/Caracas');
      var now = tz.TZDateTime.now(venezuela);
      print(now);
      //var now = DateTime.now().toUtc().add(Duration(hours: venezuelaTime.offset));
      CollectionReference showRef = _firestore.collection('shows');
      DocumentSnapshot snapshot = await showRef.doc(showId).get();
      var data = snapshot.data() as Map<String, dynamic>;
      if (data["tickets"] == 0 || numberSeats > data["tickets"]) {
        ticketsNotAvailable = true;
      }
      seats.forEach((key, position) {
        if (data["seats"][key][position] != 1) {
          seatsNotAvailable = true;
        }
      });
      if (ticketsNotAvailable) {
        return 'entradas no existentes';
      } else if (seatsNotAvailable) {
        return 'asientos no disponibles';
      }
      return '';
    } catch (e) {
      print(e);
      return false;
    }
  }
}
