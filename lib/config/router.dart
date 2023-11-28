import 'package:flutter/material.dart';
import 'package:movie_app/pages/home/home.dart';
import 'package:movie_app/pages/movie_info/movie_info.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case MovieInfoPage.routeName:
        MovieInfoArgs arguments = settings.arguments as MovieInfoArgs;
        return MaterialPageRoute(
            builder: (context) => MovieInfoPage(movie: arguments.movie));
      default:
        return MaterialPageRoute(builder: (context) => const HomePage());
    }
  }
}
