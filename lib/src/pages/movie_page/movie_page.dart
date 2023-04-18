import 'package:flutter/material.dart';

class MoviePage extends StatefulWidget {
  MoviePage(
      {Key? key,
      required this.tag,
      required this.name,
      required this.imgURL,
      required this.synopsis,
      required this.genre,
      required this.clasification,
      this.releaseDate})
      : super(key: key);
  String tag;
  String name;
  String imgURL;
  String genre;
  String clasification;
  String synopsis;
  String? releaseDate;

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  bool errorInImage = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: MediaQuery.of(context).size.width,
        child: Stack(children: [
          Hero(
            tag: widget.tag,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      onError: (exception, stackTrace) {
                        setState(() {
                          errorInImage = true;
                        });
                      },
                      image: errorInImage != true && widget.imgURL != 'NoImage'
                          ? NetworkImage(
                              widget.imgURL,
                            ) as ImageProvider
                          : const AssetImage('assets/images/no_image.jpg'))),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                width: 50.0,
                color: Colors.white,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.4,
            maxChildSize: 0.5,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    color: Colors.white),
                child: SingleChildScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            widget.name.toUpperCase(),
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 11,
                        ),
                        Text(
                          "Genero: ${widget.genre}",
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 11,
                        ),
                        Text(
                          "Clasificación: ${widget.clasification}+",
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        const Text(
                          "Sinopsis:",
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Text(
                          widget.synopsis,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        widget.releaseDate != null
                            ? Text('Fecha de Estreno: ${widget.releaseDate}')
                            : const SizedBox(),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
                //width: MediaQuery.of(context).size.width,
              );
            },
          )
        ]),
      ),
    ));
  }
}
