// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class ClassLocalizations {
  ClassLocalizations();

  static ClassLocalizations? _current;

  static ClassLocalizations get current {
    assert(_current != null,
        'No instance of ClassLocalizations was loaded. Try to initialize the ClassLocalizations delegate before accessing ClassLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<ClassLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = ClassLocalizations();
      ClassLocalizations._current = instance;

      return instance;
    });
  }

  static ClassLocalizations of(BuildContext context) {
    final instance = ClassLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of ClassLocalizations present in the widget tree. Did you add ClassLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static ClassLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<ClassLocalizations>(context, ClassLocalizations);
  }

  /// `Estrenos`
  String get estrenos {
    return Intl.message(
      'Estrenos',
      name: 'estrenos',
      desc: '',
      args: [],
    );
  }

  /// `Autenticar`
  String get autenticar {
    return Intl.message(
      'Autenticar',
      name: 'autenticar',
      desc: '',
      args: [],
    );
  }

  /// `ejemplo@gmail.com`
  String get exCorreo {
    return Intl.message(
      'ejemplo@gmail.com',
      name: 'exCorreo',
      desc: '',
      args: [],
    );
  }

  /// `Correo`
  String get correo {
    return Intl.message(
      'Correo',
      name: 'correo',
      desc: '',
      args: [],
    );
  }

  /// `Contraseña`
  String get password {
    return Intl.message(
      'Contraseña',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Ingrese un correo correcto`
  String get warmCorreo {
    return Intl.message(
      'Ingrese un correo correcto',
      name: 'warmCorreo',
      desc: '',
      args: [],
    );
  }

  /// `Contraseña debe ser de más de 6 caracteres`
  String get warmPass {
    return Intl.message(
      'Contraseña debe ser de más de 6 caracteres',
      name: 'warmPass',
      desc: '',
      args: [],
    );
  }

  /// `Ingresar`
  String get ingresar {
    return Intl.message(
      'Ingresar',
      name: 'ingresar',
      desc: '',
      args: [],
    );
  }

  /// `Crear una nueva cuenta`
  String get crearCuenta {
    return Intl.message(
      'Crear una nueva cuenta',
      name: 'crearCuenta',
      desc: '',
      args: [],
    );
  }

  /// `Espere`
  String get espere {
    return Intl.message(
      'Espere',
      name: 'espere',
      desc: '',
      args: [],
    );
  }

  /// `Peliculas en cine TV`
  String get peliCineTV {
    return Intl.message(
      'Peliculas en cine TV',
      name: 'peliCineTV',
      desc: '',
      args: [],
    );
  }

  /// `Populares`
  String get popular {
    return Intl.message(
      'Populares',
      name: 'popular',
      desc: '',
      args: [],
    );
  }

  /// `Reproducir`
  String get play {
    return Intl.message(
      'Reproducir',
      name: 'play',
      desc: '',
      args: [],
    );
  }

  /// `Ya tienes una cuenta?`
  String get alredyAccount {
    return Intl.message(
      'Ya tienes una cuenta?',
      name: 'alredyAccount',
      desc: '',
      args: [],
    );
  }

  /// `Buscar`
  String get buscar {
    return Intl.message(
      'Buscar',
      name: 'buscar',
      desc: '',
      args: [],
    );
  }

  /// `Ajustes`
  String get ajustes {
    return Intl.message(
      'Ajustes',
      name: 'ajustes',
      desc: '',
      args: [],
    );
  }

  /// `Inicio`
  String get home {
    return Intl.message(
      'Inicio',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Géneros`
  String get generos {
    return Intl.message(
      'Géneros',
      name: 'generos',
      desc: '',
      args: [],
    );
  }

  /// `Salir`
  String get logout {
    return Intl.message(
      'Salir',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Acción`
  String get accion {
    return Intl.message(
      'Acción',
      name: 'accion',
      desc: '',
      args: [],
    );
  }

  /// `Comedia`
  String get comedia {
    return Intl.message(
      'Comedia',
      name: 'comedia',
      desc: '',
      args: [],
    );
  }

  /// `Terror`
  String get terror {
    return Intl.message(
      'Terror',
      name: 'terror',
      desc: '',
      args: [],
    );
  }

  /// `Aventura`
  String get aventura {
    return Intl.message(
      'Aventura',
      name: 'aventura',
      desc: '',
      args: [],
    );
  }

  /// `Ciencia Ficción`
  String get cienciaFiccion {
    return Intl.message(
      'Ciencia Ficción',
      name: 'cienciaFiccion',
      desc: '',
      args: [],
    );
  }

  /// `Drama`
  String get drama {
    return Intl.message(
      'Drama',
      name: 'drama',
      desc: '',
      args: [],
    );
  }

  /// `Fantasía`
  String get fantasia {
    return Intl.message(
      'Fantasía',
      name: 'fantasia',
      desc: '',
      args: [],
    );
  }

  /// `Suspenso`
  String get suspenso {
    return Intl.message(
      'Suspenso',
      name: 'suspenso',
      desc: '',
      args: [],
    );
  }

  /// `Modo Oscuro`
  String get modoOscuro {
    return Intl.message(
      'Modo Oscuro',
      name: 'modoOscuro',
      desc: '',
      args: [],
    );
  }

  /// `Buscar Película`
  String get buscarPelicula {
    return Intl.message(
      'Buscar Película',
      name: 'buscarPelicula',
      desc: '',
      args: [],
    );
  }

  /// `Iniciar Sesión`
  String get iniciarSesion {
    return Intl.message(
      'Iniciar Sesión',
      name: 'iniciarSesion',
      desc: '',
      args: [],
    );
  }

  /// `¿No tienes cuenta? `
  String get noTienesCuenta {
    return Intl.message(
      '¿No tienes cuenta? ',
      name: 'noTienesCuenta',
      desc: '',
      args: [],
    );
  }

  /// `Regístrate.`
  String get registrate {
    return Intl.message(
      'Regístrate.',
      name: 'registrate',
      desc: '',
      args: [],
    );
  }

  /// `Ingresar`
  String get login {
    return Intl.message(
      'Ingresar',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Introduce aquí tu correo`
  String get aquiCorreo {
    return Intl.message(
      'Introduce aquí tu correo',
      name: 'aquiCorreo',
      desc: '',
      args: [],
    );
  }

  /// `Email o Contraseña incorrectos`
  String get wrongPassCorreo {
    return Intl.message(
      'Email o Contraseña incorrectos',
      name: 'wrongPassCorreo',
      desc: '',
      args: [],
    );
  }

  /// `Registrar usuario`
  String get registrarUsuario {
    return Intl.message(
      'Registrar usuario',
      name: 'registrarUsuario',
      desc: '',
      args: [],
    );
  }

  /// `¿Ya tienes cuenta? `
  String get yaTienesCuenta {
    return Intl.message(
      '¿Ya tienes cuenta? ',
      name: 'yaTienesCuenta',
      desc: '',
      args: [],
    );
  }

  /// `Inicia sesión.`
  String get iniciaSesion {
    return Intl.message(
      'Inicia sesión.',
      name: 'iniciaSesion',
      desc: '',
      args: [],
    );
  }

  /// `ejemplo@email.com`
  String get ejemploemail {
    return Intl.message(
      'ejemplo@email.com',
      name: 'ejemploemail',
      desc: '',
      args: [],
    );
  }

  /// `Usuario registrado con éxito`
  String get exitoRegistro {
    return Intl.message(
      'Usuario registrado con éxito',
      name: 'exitoRegistro',
      desc: '',
      args: [],
    );
  }

  /// `El Correo ya existe`
  String get existeEmail {
    return Intl.message(
      'El Correo ya existe',
      name: 'existeEmail',
      desc: '',
      args: [],
    );
  }

  /// `Introduce aquí tu nombre`
  String get typeName {
    return Intl.message(
      'Introduce aquí tu nombre',
      name: 'typeName',
      desc: '',
      args: [],
    );
  }

  /// `Nombre`
  String get nombre {
    return Intl.message(
      'Nombre',
      name: 'nombre',
      desc: '',
      args: [],
    );
  }

  /// `Introduce aquí tu apellido`
  String get typeApellido {
    return Intl.message(
      'Introduce aquí tu apellido',
      name: 'typeApellido',
      desc: '',
      args: [],
    );
  }

  /// `Apellido`
  String get apellido {
    return Intl.message(
      'Apellido',
      name: 'apellido',
      desc: '',
      args: [],
    );
  }

  /// `es_ES`
  String get idioma {
    return Intl.message(
      'es_ES',
      name: 'idioma',
      desc: '',
      args: [],
    );
  }

  String get recordar {
    return Intl.message(
      'recordar',
      name: 'recordar',
      desc: '',
      args: [],
    );
  }

  String get Peliculas {
    return Intl.message(
      'Peliculas',
      name: 'Peliculas',
      desc: '',
      args: [],
    );
  }
  String get Cerrar {
    return Intl.message(
      'Cerrar',
      name: 'Cerrar',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate
    extends LocalizationsDelegate<ClassLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'es', countryCode: 'ES'),
      Locale.fromSubtags(languageCode: 'ca', countryCode: 'ES'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<ClassLocalizations> load(Locale locale) =>
      ClassLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
