import 'package:meta/meta.dart';
import 'dart:convert';

class MovieP {
    List<MoviePP> results;

    MovieP({
        required this.results,
    });

    factory MovieP.fromRawJson(String str) => MovieP.fromJson(json.decode(str));

   

    factory MovieP.fromJson(Map<String, dynamic> json) => MovieP(
        results: List<MoviePP>.from(json["results"].map((x) => MoviePP.fromJson(x))),
    );

    
}

class MoviePP {
    String video;

    MoviePP({
        required this.video,
    });

    factory MoviePP.fromRawJson(String str) => MoviePP.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MoviePP.fromJson(Map<String, dynamic> json) => MoviePP(
        video: json["video"],
    );

    Map<String, dynamic> toJson() => {
        "video": video,
    };
}
