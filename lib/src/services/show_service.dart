import 'package:cine_app/src/models/movie_shows_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

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
                prices: []);
        movieExist.ids.add(element.id);
        movieExist.audios.add(element.audio);
        movieExist.times.add(element.hour);
        movieExist.visualizations.add(element.visualization);
        movieExist.tickets.add(element.tickets);
        movieExist.prices.add(element.price);
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
}
