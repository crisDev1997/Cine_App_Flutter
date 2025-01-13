import 'package:cine_app/src/models/movie_model.dart';
import 'package:flutter/material.dart';

import '../movie_page/movie_page.dart';
import 'card_movie.dart';

class ScrollTodayMovies extends StatelessWidget {
  ScrollTodayMovies({Key? key, this.height, required this.todayMovieList})
      : super(key: key);
  double? height;
  final List<MovieModel> todayMovieList;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 210.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, _) => const SizedBox(
          width: 6.0,
        ),
        itemCount: todayMovieList.length,
        itemBuilder: (context, index) {
          var todayMovie = todayMovieList[index];
          return GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MoviePage(
                          tag: "today${todayMovie.id}",
                          name: todayMovie.title,
                          imgURL: todayMovie.imgURL,
                          synopsis: todayMovie.synopsis,
                          genre: todayMovie.genre,
                          clasification: todayMovie.clasification.toString(),
                        ))),
            child: Hero(
              tag: "billboard-${todayMovie.id}",
              child: CardMovie(
                name: todayMovieList[index].title,
                imgURL: todayMovieList[index].imgURL,
                genre: todayMovieList[index].genre,
              ),
            ),
          );
        },
      ),
    );
  }
}
