import 'package:flutter/material.dart';

class MovieInfoArgs {
  MovieInfoArgs({required this.movie});
  final Map<String, dynamic> movie;
}

class MovieInfoPage extends StatefulWidget {
  static const String routeName = '/movieInfo';

  const MovieInfoPage({super.key, required this.movie});
  final Map<String, dynamic> movie;

  @override
  State<MovieInfoPage> createState() => _MovieInfoPageState();
}

class _MovieInfoPageState extends State<MovieInfoPage> {
  final String imageBaseUrl = 'http://image.tmdb.org/t/p/w500';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                  '$imageBaseUrl${widget.movie['poster_path']}',
                  fit: BoxFit.fill),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.09,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Image.network(
                        '$imageBaseUrl${widget.movie['poster_path']}',
                        fit: BoxFit.fill),
                  ),
                  Text(widget.movie['title'],
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  Text(
                    widget.movie['overview'],
                    textAlign: TextAlign.center,
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
