import 'package:cine_app/src/models/movie_model.dart';
import 'package:cine_app/src/pages/main_page/card_movie.dart';
import 'package:cine_app/src/pages/movie_page/movie_page.dart';
import 'package:flutter/material.dart';

class ScrollReleaseMovies extends StatelessWidget {
  ScrollReleaseMovies({Key? key, this.height, required this.releaseMovieList})
      : super(key: key);
  double? height;

  final List<MovieModel> releaseMovieList;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 200.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, _) => const SizedBox(
          width: 6.0,
        ),
        itemCount: releaseMovieList.length,
        itemBuilder: (context, index) {
          var releaseMovie = releaseMovieList[index];
          return GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MoviePage(
                          tag: "release-${releaseMovie.id}",
                          name: releaseMovie.title,
                          imgURL: releaseMovie.imgURL,
                          synopsis: releaseMovie.synopsis,
                          genre: releaseMovie.genre,
                          clasification: releaseMovie.clasification.toString(),
                          releaseDate: releaseMovie.releaseDate,
                        ))),
            child: Hero(
              tag: "release-${releaseMovie.id}",
              child: CardMovie(
                name: releaseMovieList[index].title,
                imgURL: releaseMovieList[index].imgURL,
                genre: releaseMovieList[index].genre,
                releaseDate: releaseMovieList[index].releaseDate,
              ),
            ),
          );
        },
      ),
    );
  }
}
