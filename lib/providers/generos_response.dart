import 'dart:convert';

import '../models/generos.dart';

Generos generosFromMap(String str) => Generos.fromMap(json.decode(str));

class Generos {
  Generos({
    required this.results,
  });
  List<Genero> results;
  factory Generos.fromJson(String str) => Generos.fromMap(json.decode(str));

  factory Generos.fromMap(Map<String, dynamic> json) => Generos(
        results:
            List<Genero>.from(json["results"].map((x) => Genero.fromMap(x))),
      );
}
