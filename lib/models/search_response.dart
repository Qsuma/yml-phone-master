// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromMap(jsonString);

import 'dart:convert';

import 'movie.dart';

class SearchResponse {
  SearchResponse({
    required this.results,
  });

  List<Movie> results;

  factory SearchResponse.fromJson(String str) =>
      SearchResponse.fromMap(json.decode(str));

  factory SearchResponse.fromMap(Map<String, dynamic> json) => SearchResponse(
        results: json["results"] == null
            ? []
            : List<Movie>.from(json["results"]!.map((x) => Movie.fromMap(x))),
      );
}
