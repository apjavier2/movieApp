import 'package:flutter/material.dart';

class Poster extends StatelessWidget {
  const Poster({super.key, required this.path});
  final String imageBaseUrl = 'http://image.tmdb.org/t/p/w500';
  final String path;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.6,
      child: Image.network('$imageBaseUrl$path', fit: BoxFit.fill),
    );
  }
}
