import 'models/ticket_model.dart';
import 'models/tickets_show_model.dart';

class TestData {
  Future<Map<String, List<TicketsShowModel>>> simulateTickets() async {
    Map<String, List<TicketsShowModel>> tickets = {
      '1-06-2023': [
        TicketsShowModel(
            showId: '12348597',
            ticketList: [
              TicketModel(
                  id: '12345678',
                  codQR: '123456789787',
                  showId: '12348597',
                  movieId: '12378456489',
                  userId: '12321412541321',
                  title: 'Los tipos malos',
                  imgURL: '',
                  date: '1-06-2023',
                  hour: '14:15',
                  state: 'pendency',
                  expireDate: DateTime.now()),
              TicketModel(
                  id: '12344218',
                  codQR: '1234567512317',
                  showId: '12348597',
                  movieId: '12378456489',
                  userId: '12321412541321',
                  title: 'Los tipos malos',
                  imgURL: '',
                  date: '1-06-2023',
                  hour: '14:15',
                  state: 'pendency',
                  expireDate: DateTime.now()),
              TicketModel(
                  id: '123456768',
                  codQR: '12345678978517',
                  showId: '12348597',
                  movieId: '12378456489',
                  userId: '12321412541321',
                  title: 'Los tipos malos',
                  imgURL: '',
                  date: '1-06-2023',
                  hour: '14:15',
                  state: 'pendency',
                  expireDate: DateTime.now())
            ],
            title: 'Los tipos malos',
            imgURL:
                'https://www.lavanguardia.com/peliculas-series/images/movie/poster/2022/3/w780/12CpyYe2kvY143YQ2qpxSLTL6Ez.jpg',
            date: '1-06-2023',
            hour: '14:15'),
        TicketsShowModel(
            showId: '12348598',
            ticketList: [
              TicketModel(
                  id: '1234567782',
                  codQR: '12345678978731781',
                  showId: '12348598',
                  movieId: '12378456489',
                  userId: '12321412541321',
                  title: 'Los tipos malos',
                  imgURL: '',
                  date: '1-06-2023',
                  hour: '18:15',
                  state: 'pendency',
                  expireDate: DateTime.now()),
              TicketModel(
                  id: '1234421891',
                  codQR: '12345675123175123',
                  showId: '12348598',
                  movieId: '12378456489',
                  userId: '12321412541321',
                  title: 'Los tipos malos',
                  imgURL: '',
                  date: '1-06-2023',
                  hour: '18:15',
                  state: 'pendency',
                  expireDate: DateTime.now()),
              TicketModel(
                  id: '1234567688',
                  codQR: '12345678978517543',
                  showId: '12348598',
                  movieId: '12378456489',
                  userId: '12321412541321',
                  title: 'Los tipos malos',
                  imgURL: '',
                  date: '1-06-2023',
                  hour: '18:15',
                  state: 'pendency',
                  expireDate: DateTime.now())
            ],
            title: 'Los tipos malos',
            imgURL:
                'https://www.lavanguardia.com/peliculas-series/images/movie/poster/2022/3/w780/12CpyYe2kvY143YQ2qpxSLTL6Ez.jpg',
            date: '1-06-2023',
            hour: '18:15'),
      ],
      '5-05-2023': [
        TicketsShowModel(
            showId: '12348597',
            ticketList: [
              TicketModel(
                  id: '12345678',
                  codQR: '123456789787',
                  showId: '12348597',
                  movieId: '12378456489',
                  userId: '12321412541321',
                  title: 'Los tipos malos',
                  imgURL: '',
                  date: '5-05-2023',
                  hour: '14:15',
                  state: 'pendency',
                  expireDate: DateTime.now()),
              TicketModel(
                  id: '12344218',
                  codQR: '1234567512317',
                  showId: '12348597',
                  movieId: '12378456489',
                  userId: '12321412541321',
                  title: 'Los tipos malos',
                  imgURL: '',
                  date: '5-05-2023',
                  hour: '14:15',
                  state: 'pendency',
                  expireDate: DateTime.now()),
              TicketModel(
                  id: '123456768',
                  codQR: '12345678978517',
                  showId: '12348597',
                  movieId: '12378456489',
                  userId: '12321412541321',
                  title: 'Los tipos malos',
                  imgURL: '',
                  date: '5-05-2023',
                  hour: '14:15',
                  state: 'pendency',
                  expireDate: DateTime.now())
            ],
            title: 'Los tipos malos',
            imgURL:
                'https://www.lavanguardia.com/peliculas-series/images/movie/poster/2022/3/w780/12CpyYe2kvY143YQ2qpxSLTL6Ez.jpg',
            date: '5-05-2023',
            hour: '14:15'),
        TicketsShowModel(
            showId: '12348598',
            ticketList: [
              TicketModel(
                  id: '1234567782',
                  codQR: '12345678978731781',
                  showId: '12348598',
                  movieId: 'Rp2VHItmd8F5erpd47tc',
                  userId: '12321412541321',
                  title: 'Dog: Un viaje salvaje',
                  imgURL: '',
                  date: '5-05-2023',
                  hour: '18:15',
                  state: 'pendency',
                  expireDate: DateTime.now()),
              TicketModel(
                  id: '1234421891',
                  codQR: '12345675123175123',
                  showId: '12348598',
                  movieId: 'Rp2VHItmd8F5erpd47tc',
                  userId: '12321412541321',
                  title: 'Dog: Un viaje salvaje',
                  imgURL: '',
                  date: '5-05-2023',
                  hour: '18:15',
                  state: 'pendency',
                  expireDate: DateTime.now()),
              TicketModel(
                  id: '1234567688',
                  codQR: '12345678978517543',
                  showId: '12348598',
                  movieId: 'Rp2VHItmd8F5erpd47tc',
                  userId: '12321412541321',
                  title: 'Dog: Un viaje salvaje',
                  imgURL: '',
                  date: '5-05-2023',
                  hour: '18:15',
                  state: 'pendency',
                  expireDate: DateTime.now())
            ],
            title: 'Dog: Un viaje salvaje',
            imgURL:
                'https://www.lavanguardia.com/peliculas-series/images/movie/poster/2022/2/w780/yNpSqsRuLyyrRltXvtrbXhZinqO.jpg',
            date: '5-05-2023',
            hour: '18:15'),
      ],
      '7-06-2023': [
        TicketsShowModel(
            showId: '12348597',
            ticketList: [
              TicketModel(
                  id: '12345678415',
                  codQR: '123456789787',
                  showId: '12348597',
                  movieId: 'xyaCzRVuZZnlHPBHb6A7',
                  userId: '12321412541321',
                  title: 'Red',
                  imgURL: '',
                  date: '7-06-2023',
                  hour: '14:15',
                  state: 'pendency',
                  expireDate: DateTime.now()),
              TicketModel(
                  id: '12344218416',
                  codQR: '1234567512317',
                  showId: '12348597',
                  movieId: 'xyaCzRVuZZnlHPBHb6A7',
                  userId: '12321412541321',
                  title: 'Red',
                  imgURL: '',
                  date: '7-06-2023',
                  hour: '14:15',
                  state: 'pendency',
                  expireDate: DateTime.now()),
              TicketModel(
                  id: '12345676418',
                  codQR: '12345678978517',
                  showId: '12348597',
                  movieId: 'xyaCzRVuZZnlHPBHb6A7',
                  userId: '12321412541321',
                  title: 'Red',
                  imgURL: '',
                  date: '7-06-2023',
                  hour: '14:15',
                  state: 'pendency',
                  expireDate: DateTime.now())
            ],
            title: 'Red',
            imgURL:
                'https://www.lavanguardia.com/peliculas-series/images/movie/poster/2022/3/w780/12CpyYe2kvY143YQ2qpxSLTL6Ez.jpg',
            date: '7-06-2023',
            hour: '14:15'),
      ]
    };
    return tickets;
  }
}
