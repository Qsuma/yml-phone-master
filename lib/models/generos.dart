import 'dart:convert';

class Genero {
  String id;
  String genre;
  bool isDeleted;
  dynamic deletedAt;
  DateTime updatedAt;

  Genero({
    required this.id,
    required this.genre,
    required this.isDeleted,
    this.deletedAt,
    required this.updatedAt,
  });
  factory Genero.fromJson(String str) => Genero.fromMap(json.decode(str));
  factory Genero.fromMap(Map<String, dynamic> json) => Genero(
        id: json["_id"],
        genre: json["genre"],
        isDeleted: json["isDeleted"],
        deletedAt: json["deletedAt"],
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
}
