import 'package:flutter/material.dart';

class GenresList extends StatelessWidget {
  const GenresList({super.key, required this.genres, required this.onClick});

  final List<Map<String, dynamic>> genres;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onClick(genres[index]['name'], genres[index]['id']);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Chip(
                  label: Text(genres[index]['name'],
                      style: const TextStyle(color: Colors.red))),
            ),
          );
        },
      ),
    );
  }
}
