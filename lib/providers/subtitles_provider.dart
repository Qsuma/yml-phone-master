/*import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/subtitulo_response.dart';
import '../src/preferencias_usuario.dart';

class SubtitlesProvider extends ChangeNotifier {
  final String id;
  final String Lenguage;
  final prefs = PreferenciasUsuario();

  SubtitlesProvider(this.id, this.Lenguage) {
    getSubtitles(id, Lenguage);
  }
  getSubtitles(String id, String Lenguage) async {
    var url = Uri.http(
      'yml-live.me:3003',
      '/movies/subtitles/$id/$Lenguage',
    );
    final response = await http.get(url, headers: {'auth-token': prefs.Token});
    final subtitlesResponse = SubtitlesResponse.fromJson(response.body);
    if (response.statusCode != 200) return null;
    //final decodedData = json.decode(response.body);
  
  }
}
*/