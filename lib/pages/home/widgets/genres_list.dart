import 'package:flutter/material.dart';

class GenresList extends StatelessWidget {
  const GenresList(
      {super.key,
      required this.genres,
      required this.onClick,
      this.selectedId});

  final List<Map<String, dynamic>> genres;
  final Function onClick;
  final num? selectedId;

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
                  backgroundColor: genres[index]['id'] == selectedId
                      ? Colors.grey[800]
                      : null,
                  label: Text(genres[index]['name'],
                      style: const TextStyle(color: Colors.red))),
            ),
          );
        },
      ),
    );
  }
}
