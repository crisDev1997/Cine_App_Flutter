import 'package:cine_app/src/pages/movie_page/movie_page.dart';
import 'package:flutter/material.dart';

import '../../models/movie_model.dart';

class ContainerReleasedMovieList extends StatelessWidget {
  const ContainerReleasedMovieList(
      {Key? key, required this.future, required this.scrollController})
      : super(key: key);
  final Future<List<MovieModel>> future;
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: scrollController,
        child: FutureBuilder(
            future: future,
            builder: (_, AsyncSnapshot<List<MovieModel>> snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                List<MovieModel> releaseDateMovieList = snapshot.data ?? [];
                return ListView.separated(
                  controller: scrollController,
                  //physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: releaseDateMovieList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => ContainerReleasedMovie(
                      key: ValueKey(releaseDateMovieList[index].id),
                      id: releaseDateMovieList[index].id,
                      title: releaseDateMovieList[index].title,
                      imgURL: releaseDateMovieList[index].imgURL,
                      genre: releaseDateMovieList[index].genre,
                      releaseDate: releaseDateMovieList[index].releaseDate,
                      clasification: releaseDateMovieList[index].clasification,
                      synopsis: releaseDateMovieList[index].synopsis),
                  separatorBuilder: (BuildContext context, _) =>
                      const SizedBox(height: 10.0),
                );
              } else {
                return Container();
              }
            }),
      ),
    );
  }
}

class ContainerReleasedMovie extends StatelessWidget {
  const ContainerReleasedMovie(
      {Key? key,
      required this.id,
      required this.title,
      required this.imgURL,
      required this.genre,
      required this.releaseDate,
      required this.clasification,
      required this.synopsis})
      : super(key: key);
  final String id;
  final String title;
  final String genre;
  final String imgURL;
  final int clasification;
  final String releaseDate;
  final String synopsis;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(25.0)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              child: Image.network(
                imgURL,
                width: 125,
                fit: BoxFit.fill,
                height: 225,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.50,
                child: Text(
                  title.toUpperCase(),
                  maxLines: 3,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "Genero: $genre",
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                "Estreno: $releaseDate",
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.50,
                child: Text(
                  synopsis,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MoviePage(
                                    tag: "release$id",
                                    name: title,
                                    imgURL: imgURL,
                                    synopsis: synopsis,
                                    genre: genre,
                                    clasification: clasification.toString(),
                                    releaseDate: releaseDate,
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(255, 97, 113, 1)),
                    child: const Text(
                      "Sinopsis completa",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
