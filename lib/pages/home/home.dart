import 'package:flutter/material.dart';
import 'package:movie_app/pages/home/widgets/poster.dart';
import 'package:movie_app/pages/movie_info/movie_info.dart';
import 'package:movie_app/utils/mock/movie_mock.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> moviesMock = MoviesMock.moviesMock;
  List<Map<String, dynamic>> nowPlayingMoviesMock =
      MoviesMock.nowPlayingMoviesMock;
  final String imageBaseUrl = 'http://image.tmdb.org/t/p/w500';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text('Movie'),
            Poster(path: moviesMock[0]['poster_path']),
            const Text('Now Playing'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: nowPlayingMoviesMock.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(MovieInfoPage.routeName,
                            arguments: MovieInfoArgs(
                                movie: nowPlayingMoviesMock[index]));
                      },
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            color: Colors.black,
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Image.network(
                                '$imageBaseUrl${nowPlayingMoviesMock[index]['poster_path']}',
                                fit: BoxFit.fill),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Text(nowPlayingMoviesMock[index]['title'],
                                  textAlign: TextAlign.center)),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
