import 'package:cine_app/src/pages/release_movies_page/container_released_movie_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/movie_provider.dart';

class ReleaseMoviesPage extends StatefulWidget {
  const ReleaseMoviesPage({Key? key}) : super(key: key);

  @override
  State<ReleaseMoviesPage> createState() => _ReleaseMoviesPageState();
}

class _ReleaseMoviesPageState extends State<ReleaseMoviesPage> {
  late ScrollController scrollController;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = context.watch<MovieProvider>();
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      controller: scrollController,
      child: Container(
          color: Colors.white54,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30.0, bottom: 20.0),
                child: const Text(
                  "Estrenos",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              ContainerReleasedMovieList(
                future: movieProvider.fetchRecentlyReleasedMovies(),
                scrollController: scrollController,
              ),
              const SizedBox(
                height: 50,
              )
            ],
          )),
    );
  }
}
