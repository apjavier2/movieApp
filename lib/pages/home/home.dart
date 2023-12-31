import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/pages/home/widgets/genres_list.dart';
import 'package:movie_app/pages/home/widgets/poster.dart';
import 'package:movie_app/utils/mock/genres_mock.dart';
import 'package:movie_app/utils/mock/movie_mock.dart';
import 'package:movie_app/widgets/movies_horizontal_view.dart';

import '../../data/model/movie/movie.model.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> genresMock = GenresMock.genresMock;

  final List<Map<String, dynamic>> moviesMock = MoviesMock.moviesMock;
  final List<Map<String, dynamic>> nowPlayingMoviesMock =
      MoviesMock.nowPlayingMoviesMock;
  final List<Map<String, dynamic>> popularMoviesMock =
      MoviesMock.popularMoviesMock;
  final List<Map<String, dynamic>> topRatedMoviesMock =
      MoviesMock.topRatedMoviesMock;
  final List<Map<String, dynamic>> upcomingMoviesMock =
      MoviesMock.upcomingMoviesMock;
  final String imageBaseUrl = 'http://image.tmdb.org/t/p/w500';
  int currentIndex = 0;
  double opacity = 1.0;
  final Dio dio = Dio();
  final String token = dotenv.env['API_TOKEN'] ?? '';

  Future<List<Movie>> getMovieList() async {
    try {
      Response response = await dio.get(
          'https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      List<dynamic> movieData = response.data['results'];
      List<Movie> movies =
          movieData.map((data) => Movie.fromJson(data)).toList();

      return movies;
    } on DioException catch (err) {
      throw err.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    getMovieList();
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      setState(() {
        opacity = 0.0;
      });
      Timer(const Duration(seconds: 2), () {
        setState(() {
          currentIndex = (currentIndex + 1) % moviesMock.length;
          opacity = 1.0;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const Text('Movie'),
              GenresList(
                  genres: genresMock,
                  onClick: (String genreSelected, int genreID) {
                    print('Selected $genreSelected : $genreID');
                  }),
              AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(seconds: 2),
                child: Poster(path: moviesMock[currentIndex]['poster_path']),
              ),

              FutureBuilder(
                  future: getMovieList(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return MoviesHorizontalView(
                          movies: snapshot.data!, title: "Now Playing");
                    }
                    return const CircularProgressIndicator();
                  })),
              // MoviesHorizontalView(
              //     movies: nowPlayingMoviesMock, title: "Now Playing"),

              // MoviesHorizontalView(movies: popularMoviesMock, title: "Popular"),
              // MoviesHorizontalView(
              //     movies: topRatedMoviesMock, title: "Top Rated"),
              // MoviesHorizontalView(
              //     movies: upcomingMoviesMock, title: "Upcoming"),
            ],
          ),
        ),
      ),
    );
  }
}
