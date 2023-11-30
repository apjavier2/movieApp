import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_app/pages/home/widgets/poster.dart';
import 'package:movie_app/utils/mock/movie_mock.dart';
import 'package:movie_app/widgets/movies_horizontal_view.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          child: Column(
            children: [
              const Text('Movie'),
              AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(seconds: 2),
                child: Poster(path: moviesMock[currentIndex]['poster_path']),
              ),
              MoviesHorizontalView(
                  movies: nowPlayingMoviesMock, title: "Now Playing"),
              MoviesHorizontalView(movies: popularMoviesMock, title: "Popular"),
              MoviesHorizontalView(
                  movies: topRatedMoviesMock, title: "Top Rated"),
              MoviesHorizontalView(
                  movies: upcomingMoviesMock, title: "Upcoming"),
            ],
          ),
        ),
      ),
    );
  }
}
