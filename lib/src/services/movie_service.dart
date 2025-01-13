import 'package:cine_app/src/models/movie_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class MovieService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<MovieModel>?> getRecentlyReleasedMovies() async {
    try {
      CollectionReference movieRef = _firestore.collection('movies');
      QuerySnapshot snapshot =
          await movieRef.where("recentlyReleased", isEqualTo: true).get();
      if (snapshot.size > 0) {
        List<MovieModel> movies = [];
        movies = snapshot.docs
            .map((doc) {
              var data = doc.data() as Map<String, dynamic>;
              if (data.keys.contains("id") &&
                  data.keys.contains("title") &&
                  data.keys.contains("synopsis") &&
                  data.keys.contains("genre") &&
                  data.keys.contains("duration") &&
                  data.keys.contains("releaseDate") &&
                  data.keys.contains("clasification") &&
                  data.keys.contains("imgURL")) {
                return MovieModel.fromJson(data);
              }
            })
            .whereType<MovieModel>()
            .toList();
        return movies;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  Future<List<MovieModel>?> getOnBillboardMovies() async {
    try {
      CollectionReference movieRef = _firestore.collection('movies');
      QuerySnapshot snapshot =
          await movieRef.where("onBillboard", isEqualTo: true).get();

      if (snapshot.size > 0) {
        List<MovieModel> movies = [];
        movies = snapshot.docs
            .map((doc) {
              var data = doc.data() as Map<String, dynamic>;
              //print(data);
              if (data.keys.contains("id") &&
                  data.keys.contains("title") &&
                  data.keys.contains("synopsis") &&
                  data.keys.contains("genre") &&
                  data.keys.contains("duration") &&
                  data.keys.contains("releaseDate") &&
                  data.keys.contains("clasification") &&
                  data.keys.contains("imgURL") &&
                  data.keys.contains("onBillboard")) {
                return MovieModel.fromJson(data);
              }
            })
            .whereType<MovieModel>()
            .toList();

        return movies;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  Future<List<MovieModel>?> getComingSoonMovies() async {
    try {
      CollectionReference movieRef = _firestore.collection('movies');
      QuerySnapshot snapshot =
          await movieRef.where("comingSoon", isEqualTo: true).get();
      if (snapshot.size > 0) {
        List<MovieModel> movies = [];
        movies = snapshot.docs
            .map((doc) {
              var data = doc.data() as Map<String, dynamic>;
              if (data.keys.contains("id") &&
                  data.keys.contains("title") &&
                  data.keys.contains("synopsis") &&
                  data.keys.contains("genre") &&
                  data.keys.contains("duration") &&
                  data.keys.contains("releaseDate") &&
                  data.keys.contains("clasification") &&
                  data.keys.contains("imgURL")) {
                return MovieModel.fromJson(data);
              }
            })
            .whereType<MovieModel>()
            .toList();
        return movies;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }
}
