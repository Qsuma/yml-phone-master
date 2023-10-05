import 'dart:convert';

class Movie {
  Movie({
    required this.originalTitle,
    required this.backdropPath,
    required this.originalLanguage,
    required this.overview,
   
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.genreId,
    required this.isDeleted,
    this.deletedAt,
    required this.updatedAt,
    this.id,
  });

  String originalTitle;
  String backdropPath;
  String originalLanguage;
  String overview;

  String releaseDate;
  String title;
  String video;
  String genreId;
  bool isDeleted;
  dynamic deletedAt;
  DateTime updatedAt;
  String? id;

  factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

  factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        originalTitle: json["originalTitle"],
        backdropPath: json["backdropPath"],
        originalLanguage: json["originalLanguage"],
        overview: json["overview"],
       
        releaseDate: json["releaseDate"],
        title: json["title"],
        video: json["video"],
        genreId: json["genre_id"],
        isDeleted: json["isDeleted"],
        deletedAt: json["deletedAt"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
      );
}
