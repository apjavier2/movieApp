import 'package:flutter/material.dart';
import 'package:movie_app/data/model/movie/movie.model.dart';
import 'package:movie_app/pages/movie_info/movie_info.dart';

class MoviesGridView extends StatelessWidget {
  const MoviesGridView({
    super.key,
    required this.movies,
  });
  final List<Movie> movies;
  final String imageBaseUrl = 'http://image.tmdb.org/t/p/w500';
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 8.0, // Spacing between columns
            mainAxisSpacing: 8.0, // Spacing between rows
            childAspectRatio: 0.7),
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
                  height: MediaQuery.of(context).size.height * 0.21,
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
        });
  }
}
