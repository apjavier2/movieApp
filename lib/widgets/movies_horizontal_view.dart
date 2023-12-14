import 'package:flutter/material.dart';
import 'package:movie_app/data/model/movie/movie.model.dart';
import 'package:movie_app/pages/movie_info/movie_info.dart';

class MoviesHorizontalView extends StatelessWidget {
  const MoviesHorizontalView(
      {super.key, required this.movies, required this.title});
  final List<Movie> movies;
  final String title;
  final String imageBaseUrl = 'http://image.tmdb.org/t/p/w500';

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align(
          alignment: Alignment.centerLeft,
          child: Text(title, style: const TextStyle(color: Colors.white))),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.3,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => {
                Navigator.of(context).pushNamed(MovieInfoPage.routeName,
                    arguments: MovieInfoArgs(movie: movies[index]))
              },
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                    height: MediaQuery.of(context).size.height * 0.20,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Image.network(
                      "$imageBaseUrl${movies[index].poster_path}",
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Text(
                        movies[index].original_title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      ))
                ],
              ),
            );
          },
        ),
      ),
    ]);
  }
}
