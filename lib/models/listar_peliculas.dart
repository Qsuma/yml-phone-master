// To parse this JSON data, do
//
//     final nowPlayingResponse = nowPlayingResponseFromMap(jsonString);

import 'dart:convert';

import 'movie.dart';

class ListaPeliculas {
  ListaPeliculas({
    required this.results,
  });

  List<Movie> results;

  factory ListaPeliculas.fromJson(String str) =>
      ListaPeliculas.fromMap(json.decode(str));

  factory ListaPeliculas.fromMap(Map<String, dynamic> json) => ListaPeliculas(
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
      );
}
