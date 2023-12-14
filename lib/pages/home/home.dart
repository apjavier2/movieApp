import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/pages/home/widgets/genres_list.dart';
import 'package:movie_app/pages/home/widgets/poster.dart';
import 'package:movie_app/utils/mock/genres_mock.dart';
import 'package:movie_app/utils/mock/movie_mock.dart';
import 'package:movie_app/widgets/movies_grid_view.dart';
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
  num? genreSelectedId;

  Future<List<Movie>> getMovieList(String listCategory) async {
    try {
      Response response = await dio.get(
          'https://api.themoviedb.org/3/movie/$listCategory?language=en-US&page=1',
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

  Future<List<Movie>> getMoviesByGenre(num genreId) async {
    try {
      Response response = await dio.get(
          'https://api.themoviedb.org/3/discover/movie?language=en-US&page=1&with_genres=$genreId',
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
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const Text('Movie'),
                GenresList(
                    selectedId: genreSelectedId,
                    genres: genresMock,
                    onClick: (String genreSelected, int genreID) {
                      setState(() {
                        if (genreSelectedId == genreID) {
                          genreSelectedId = null;
                        } else {
                          genreSelectedId = genreID;
                        }
                      });
                    }),
                if (genreSelectedId == null) ...[
                  AnimatedOpacity(
                    opacity: opacity,
                    duration: const Duration(seconds: 2),
                    child:
                        Poster(path: moviesMock[currentIndex]['poster_path']),
                  ),
                  FutureBuilder(
                      future: getMovieList('now_playing'),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          return MoviesHorizontalView(
                              movies: snapshot.data!, title: "Now Playing");
                        }
                        return const CircularProgressIndicator();
                      })),
                  FutureBuilder(
                      future: getMovieList('popular'),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          return MoviesHorizontalView(
                              movies: snapshot.data!, title: "Popular");
                        }
                        return const CircularProgressIndicator();
                      })),
                  FutureBuilder(
                      future: getMovieList('top_rated'),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          return MoviesHorizontalView(
                              movies: snapshot.data!, title: "Top Rated");
                        }
                        return const CircularProgressIndicator();
                      })),
                  FutureBuilder(
                      future: getMovieList('upcoming'),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          return MoviesHorizontalView(
                              movies: snapshot.data!, title: "Upcoming");
                        }
                        return const CircularProgressIndicator();
                      })),
                ] else ...[
                  FutureBuilder(
                      future: getMoviesByGenre(genreSelectedId!),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          return MoviesGridView(movies: snapshot.data!);
                        }
                        return const CircularProgressIndicator();
                      })),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
