import 'dart:convert';

class SubtitlesResponse {
  SubtitlesResponse({
    required this.results,
  });

  List<String> results;

  factory SubtitlesResponse.fromJson(String str) =>
      SubtitlesResponse.fromMap(json.decode(str));

  factory SubtitlesResponse.fromMap(Map<String, dynamic> json) =>
      SubtitlesResponse(
        results: List<String>.from(json["results"].map((x) => x)),
      );
}
