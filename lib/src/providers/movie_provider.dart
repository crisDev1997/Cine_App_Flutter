import 'package:cine_app/src/models/movie_model.dart';
import 'package:cine_app/src/services/movie_service.dart';
import 'package:flutter/material.dart';

class MovieProvider extends ChangeNotifier {
  List<MovieModel> _comingSoonMovies = [];
  List<MovieModel> _onBillboardMovies = [];
  // ignore: avoid_init_to_null
  List<MovieModel> _recentlyReleasedMovies = [];

  List<MovieModel> get comingSoonList => _comingSoonMovies;
  List<MovieModel> get onBillboardList => _onBillboardMovies;

  set onBillboardlist(List<MovieModel> onBillboardList) {
    _onBillboardMovies = onBillboardList;
    notifyListeners();
  }

  set comingSoonList(List<MovieModel> comingSoonList) {
    _comingSoonMovies = comingSoonList;
    notifyListeners();
  }

  Future<List<MovieModel>> fetchRecentlyReleasedMovies() async {
    // ignore: prefer_is_empty
    try {
      if (_recentlyReleasedMovies.isNotEmpty) {
        return _recentlyReleasedMovies;
      }
      final MovieService movieService = MovieService();
      List<MovieModel>? list = await movieService.getRecentlyReleasedMovies();
      _recentlyReleasedMovies = list ?? [];
      notifyListeners();
      return _recentlyReleasedMovies;
    } catch (e) {
      return [];
    }
  }

  Future<List<MovieModel>> refreshRecentlyReleasedMovies() async {
    final MovieService movieService = MovieService();
    List<MovieModel>? list = await movieService.getRecentlyReleasedMovies();
    _recentlyReleasedMovies = list ?? [];
    notifyListeners();
    return _recentlyReleasedMovies;
  }

  Future<void> fetchComingSoonMovies() async {
    final MovieService movieService = MovieService();
    List<MovieModel>? list = await movieService.getComingSoonMovies();
    _comingSoonMovies = list ?? [];
    notifyListeners();
  }

  Future<void> fetchOnBillboardMovies() async {
    final MovieService movieService = MovieService();
    List<MovieModel>? list = await movieService.getOnBillboardMovies();
    _onBillboardMovies = list ?? [];
    notifyListeners();
  }
}
