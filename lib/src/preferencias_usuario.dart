// ignore_for_file: non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

import '../screens/details_screens.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia = PreferenciasUsuario._internal();
  factory PreferenciasUsuario() {
    return _instancia;
  }
  PreferenciasUsuario._internal();
  late SharedPreferences _globals;
  initPrefs() async {
    _globals = await SharedPreferences.getInstance();
  }

  int get Ejemplo {
    return _globals.getInt('Ejemplo') ?? 1;
  }

  set Ejemplo(int value) {
    _globals.setInt('Ejemplo', value);
  }

  bool get ModoOscuro {
    return _globals.getBool('ModoOscuro') ?? false;
  }

  set ModoOscuro(bool value) {
    _globals.setBool('ModoOscuro', value);
  }

  String get Idioma {
    if (prefs.Ejemplo == 1) {
      return _globals.getString('Idioma') ?? 'es-ES';
    }

    return _globals.getString('Idioma') ?? 'en-EN';
  }

  set Idioma(String value) {
    _globals.setString('Idioma', value);
  }

  String get Token {
    return _globals.getString('Token') ?? '';
  }

  set Token(String value) {
    _globals.setString('Token', value);
  }

  String get usuario {
    return _globals.getString('usuario') ?? '';
  }

  set usuario(String value) {
    _globals.setString('usuario', value);
  }

  String get password {
    return _globals.getString('password') ?? '';
  }

  set password(String value) {
    _globals.setString('password', value);
  }
  String get deviceId {
    return _globals.getString('deviceId') ?? '';
  }

  set deviceId(String value) {
    _globals.setString('deviceId', value);
  }
  String get model {
    return _globals.getString('model') ?? '';
  }

  set model(String value) {
    _globals.setString('model', value);
  }
  String get Devices {
    return _globals.getString('Devices') ?? '';
  }

  set Devices(String value) {
    _globals.setString('Devices', value);
  }
  bool get Rememberme {
    return _globals.getBool('rememberme') ?? false;
  }

  set Rememberme(bool value) {
    _globals.setBool('rememberme', value);
  }
}
