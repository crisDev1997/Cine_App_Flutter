import 'package:cine_app/src/pages/main_page/scroll_promos.dart';
import 'package:cine_app/src/pages/main_page/scroll_release_movies.dart';
import 'package:cine_app/src/pages/main_page/scroll_today_movies.dart';
import 'package:cine_app/src/providers/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/movie_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var testMovie = [
    {
      "id": "1",
      "name": "Uncharted",
      "imgURL":
          "https://www.lavanguardia.com/peliculas-series/images/movie/poster/2022/2/w780/6JdHIhRkzhvzxyZKK9eWsrqTliN.jpg",
      "synopsis":
          " La fortuna favorece a los audaces.\n Descubre la primera aventura de Nathan Drake, un joven, astuto y carismático cazatesoros, con su ingenioso compañero Victor “Sully” Sullivan. En una aventura de acción que se extiende por todo el mundo, ambos se embarcan en una peligrosa búsqueda de “el mayor tesoro nunca antes encontrado” al tiempo que rastrean las claves que les podrían conducir al hermano de Nathan, perdido hace ya mucho tiempo. ",
      "genre": "Acción",
      "clasification": "16",
      "audio": "Doblado",
      "visualization": "2D",
      "times": ["10:00", "12:00", "13:00", "14:00"],
      "releaseDate": "11 de noviembre"
    },
    {
      "id": "2",
      "name": "Doctor Strange en el multiverso de la locura",
      "imgURL":
          "https://www.lavanguardia.com/peliculas-series/images/movie/poster/2022/5/w780/uOnutpXJdDWyWzUCkApkahPSKuy.jpg",
      "synopsis":
          "Entra en una nueva dimensión de Strange.\n Viaja a lo desconocido con el Doctor Strange, quien, con la ayuda de tanto antiguos como nuevos aliados místicos, recorre las complejas y peligrosas realidades alternativas del multiverso para enfrentarse a un nuevo y misterioso adversario. ",
      "genre": "Fantasía",
      "clasification": "13",
      "audio": "Subtitulado",
      "visualization": "3D",
      "times": ["10:00", "12:00", "13:00", "14:00"],
      "releaseDate": "11 de noviembre"
    },
    {
      "id": "3",
      "name": "Minions: El origen de Gru",
      "imgURL":
          "https://www.lavanguardia.com/peliculas-series/images/movie/poster/2022/6/w780/zCdvIdb6SvoaOzTqCWFQdCEmOXq.jpg",
      "synopsis":
          "Ha nacido un villano.\nMucho antes de convertirse en un genio del mal, Gru no era más que un chaval de 12 años en plenos años 70 tratando de conquistar el mundo desde el sótano de su casa de un barrio residencial cualquiera. Y no le iba demasiado bien. Pero cuando Gru se cruza en su camino con Kevin, Stuart, Bob, y Otto —un nuevo Minion con aparato en los dientes y desesperado por sentirse aceptado—, esta inesperada familia unirá fuerzas para construir su primera guarida, diseñar sus primeras armas y llevar a cabo sus primeras misiones. ",
      "genre": "Animado",
      "clasification": "13",
      "audio": "Doblado",
      "visualization": "2D",
      "times": ["10:00", "12:00", "13:00", "14:00"],
      "releaseDate": "11 de noviembre"
    },
    {
      "id": "4",
      "name": "El hombre del norte",
      "imgURL":
          "https://www.lavanguardia.com/peliculas-series/images/movie/poster/2022/4/w780/rdx0bIkwxW3EHvWn5kxZBFUT1Am.jpg",
      "synopsis":
          "El príncipe Amleth está a punto de convertirse en hombre pero, en ese momento, su tío asesina brutalmente a su padre y secuestra a la madre del niño. Dos décadas después, Amleth es un vikingo que tiene la misión de salvar a su madre.",
      "genre": "Drama",
      "clasification": "16",
      "audio": "Doblado",
      "visualization": "3D",
      "times": ["10:00", "12:00", "13:00", "14:00"],
      "releaseDate": "11 de noviembre"
    },
    {
      "id": "5",
      "name": "Bullet Train",
      "imgURL":
          "https://www.lavanguardia.com/peliculas-series/images/movie/poster/2022/7/w780/ybSIUt48PsM08F4UZwHdjL9ZVG2.jpg",
      "synopsis":
          "El final de la línea es solo en principio.\nCinco asesinos a sueldo se encuentran a bordo de un tren bala que viaja de Tokio a Morioka con unas pocas paradas intermedias. Descubren que sus misiones no son ajenas entre sí. La pregunta es quién saldrá vivo del tren y qué les espera en la estación final. ",
      "genre": "Acción",
      "clasification": "16",
      "audio": "Doblado",
      "visualization": "3D",
      "times": ["10:00", "12:00", "13:00", "14:00"],
      "releaseDate": "11 de noviembre"
    },
    {
      "id": "6",
      "name": "Scream",
      "imgURL":
          "https://www.lavanguardia.com/peliculas-series/images/movie/poster/2022/1/w780/cIgmdAhesIqn2ykJfbNFMQYdxkO.jpg",
      "synopsis":
          "Siempre es alguien que conoces.\nUna nueva entrega de la saga de terror 'Scream' que seguirá a una mujer que regresa a su ciudad natal para intentar descubrir quién ha estado cometiendo una serie de crímenes atroces. ",
      "genre": "Terror",
      "clasification": "16",
      "audio": "Doblado",
      "visualization": "3D",
      "times": ["10:00", "12:00", "13:00", "14:00"],
      "releaseDate": "11 de noviembre"
    },
    {
      "id": "7",
      "name": "Los tipos malos",
      "imgURL":
          "https://www.lavanguardia.com/peliculas-series/images/movie/poster/2022/3/w780/12CpyYe2kvY143YQ2qpxSLTL6Ez.jpg",
      "synopsis":
          "Ser bueno no es tan divertido.\nCinco villanos notorios: el Sr. Lobo, Sr. Serpiente, Sr. Piraña, Sr. Tiburón y Srta. Tarántula, que han pasado toda una vida juntos realizando grandes atracos. ",
      "times": ["10:00", "12:00", "13:00", "14:00"],
      "genre": "Drama",
      "clasification": "18",
      "visualization": "3D",
      "audio": "Doblado",
      "releaseDate": "11 de noviembre"
    },
    {
      "id": "8",
      "name": "Dog: Un viaje salvaje",
      "imgURL":
          "https://www.lavanguardia.com/peliculas-series/images/movie/poster/2022/2/w780/yNpSqsRuLyyrRltXvtrbXhZinqO.jpg",
      "synopsis":
          "Un asqueroso animal no apto para la compañía humana y un perro.\nUn guardabosques del ejército y su perro se embarcan en un viaje por carretera a lo largo de la Pacific Coast Highway para asistir al funeral de un amigo. ",
      "times": ["10:00", "12:00", "13:00", "14:00"],
      "genre": "Comedia",
      "clasification": "13",
      "audio": "Doblado",
      "visualization": "3D",
      "releaseDate": "11 de noviembre"
    },
    {
      "id": "9",
      "name": "Dog: Un viaje salvaje",
      "imgURL":
          "https://www.lavanguardia.com/peliculas-series/images/movie/poster/2022/2/w780/yNpSqsRuLyyrRltXvtrbXhZinqO.jpg",
      "synopsis":
          "Un asqueroso animal no apto para la compañía humana y un perro.\n\nUn guardabosques del ejército y su perro se embarcan en un viaje por carretera a lo largo de la Pacific Coast Highway para asistir al funeral de un amigo.\n\n Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem sed risus ultricies tristique nulla aliquet enim. Morbi tristique senectus et netus et malesuada. Amet dictum sit amet justo donec enim diam. Lorem donec massa sapien faucibus et molestie ac feugiat sed. Tincidunt ornare massa eget egestas purus viverra accumsan in nisl. Pharetra diam sit amet nisl suscipit adipiscing bibendum est. Aliquam nulla facilisi cras fermentum odio eu feugiat. Aliquam eleifend mi in nulla posuere sollicitudin aliquam ultrices sagittis. A diam maecenas sed enim ut sem viverra aliquet eget. Ullamcorper morbi tincidunt ornare massa eget egestas purus. Eget aliquet nibh praesent tristique magna sit amet purus gravida. Id leo in vitae turpis massa sed elementum. Adipiscing bibendum est ultricies integer quis auctor. Sed adipiscing diam donec adipiscing tristique risus nec feugiat in.\n Vulputate dignissim suspendisse in est ante in nibh mauris. Iaculis nunc sed augue lacus. Semper risus in hendrerit gravida. Scelerisque viverra mauris in aliquam sem fringilla ut morbi. Nec tincidunt praesent semper feugiat nibh. In nisl nisi scelerisque eu. Viverra justo nec ultrices dui sapien eget mi. Nisl vel pretium lectus quam. Mauris commodo quis imperdiet massa tincidunt. Donec et odio pellentesque diam. Amet justo donec enim diam vulputate ut pharetra sit amet. Ullamcorper velit sed ullamcorper morbi tincidunt ornare. Sit amet aliquam id diam. Nunc mi ipsum faucibus vitae aliquet nec ullamcorper sit. Dignissim convallis aenean et tortor. Ut tristique et egestas quis ipsum. Nunc sed velit dignissim sodales ut eu. Arcu risus quis varius quam quisque id. ",
      "times": ["10:00", "12:00", "13:00", "14:00"],
      "genre": "Drama",
      "clasification": "13",
      "audio": "Doblado",
      "visualization": "3D",
      "releaseDate": "11 de noviembre"
    },
  ];

  var testPromos = [
    {
      "id": "promo1",
      "title": "promo1",
      "imgURL":
          "https://img.freepik.com/vector-gratis/banner-promocion-2x1_52683-50845.jpg?w=2000",
      "description": "Octubre..."
    },
    {
      "id": "promo2",
      "title": "promo2",
      "imgURL":
          "https://m8r8j2c8.stackpathcdn.com/real/viralsorteosveranorrss.jpg",
      "description": "Octubre..."
    },
    {
      "title": "promo3",
      "imgURL":
          "https://www.procinal.com/uploads/HOME/Noticias_Destacados/PROMOCIONES/Promo-CumpleCF.png",
      "description": "Octubre..."
    },
    {
      "id": "promo4",
      "title": "promo4",
      "imgURL":
          "https://static.cinepolis.com/marcas/club-cinepolis-id/img/promociones/1/202263133139106.jpg",
      "description": "Octubre..."
    },
    {
      "id": "promo5",
      "title": "promo5",
      "imgURL":
          "https://cdn.bolivia.com/sdi/2015/10/06/3fabc084459f4bf9a4aa41c47b72096c.jpg",
      "description": "Octubre..."
    },
    {
      "id": "promo6",
      "title": "promo6",
      "imgURL":
          "https://media.informabtl.com/wp-content/uploads/2022/08/7c090568-fiesta-del-cine-mexicano1-768x431.jpeg",
      "description": "Octubre..."
    }
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = context.watch<MovieProvider>();
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            FutureBuilder(
                future: movieProvider.fetchRecentlyReleasedMovies(),
                builder: (_, AsyncSnapshot<List<MovieModel>> snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    final recentlyList = snapshot.data;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Estrenos',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ScrollReleaseMovies(
                          releaseMovieList: recentlyList ?? [],
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Cartelera de Hoy',
                  style: TextStyle(fontSize: 18.0),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Ver Todo ->',
                    style: TextStyle(color: Colors.blue[400]),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            ScrollTodayMovies(
              todayMovieList: testMovie,
            ),
            const SizedBox(
              height: 30.0,
            ),
            const Text(
              "Promociones ",
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ScrollPromos(
              promoList: testPromos,
              height: 100,
            ),
            const SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
