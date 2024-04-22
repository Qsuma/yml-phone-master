// To parse this JSON data, do
//
//     final nowPlayingResponse = nowPlayingResponseFromMap(jsonString);

import 'dart:convert';

import '../globals/globals.dart';
import 'movie.dart';

class ListaPeliculas {
  ListaPeliculas({
    required this.results,
  });
  List<Movie> results;

  factory ListaPeliculas.fromJson(String str){
    if (str !="Error" &&  str!="{}") {
      return ListaPeliculas.fromMap(json.decode(str));
    }
      else {
        const str2="{"
            "results: []"
            "}";
        return ListaPeliculas.fromMap(json.decode(str2));
      }

  }



  factory ListaPeliculas.fromMap(Map<String, dynamic> json){
    PPrint(json);
    return  ListaPeliculas(
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
      );
  }

}
