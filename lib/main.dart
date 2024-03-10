import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:device_info_plus/device_info_plus.dart';



import 'package:window_manager/window_manager.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:page_transition/page_transition.dart';
//importacion de los paquetes de localizacion
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:yml/screens/TV_screens/login_screen.dart';


import 'globals/globals.dart';

import 'generated/l10n.dart';
import 'providers/generos_provider.dart';
import 'providers/movie_providers.dart';
import 'providers/user_provider.dart';
import 'screens/details_screens.dart';
import 'screens/login_screen.dart';
import 'screens/movie_screen.dart';
import 'screens/register_screen.dart';
import 'screens/screens/HomeScreen.dart';
import 'screens/settings_screen.dart';
import 'src/bloc/provider.dart';
import 'src/preferencias_usuario.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'dart:io' show Platform;
import 'package:wakelock_plus/wakelock_plus.dart';
void main() async {
  DartVLC.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  late bool isTv= false;
  if(Platform.isAndroid){
 final deviceInfo = DeviceInfoPlugin();
 final androidInfo = await deviceInfo.androidInfo;
isTv = androidInfo.systemFeatures.contains('android.software.leanback');
 }
   WidgetsFlutterBinding.ensureInitialized();
    WakelockPlus.enable();
  final prefs = PreferenciasUsuario();
  await prefs.initPrefs();
  
  
  if(Platform.isWindows){ 
  
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    fullScreen: false,
    size: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    windowManager.setFullScreen(true);

  });}
 
  


  runApp( 
 // DartVLCExample()
   AppState(isTv: isTv,)
  
  );
}

class AppState extends StatelessWidget {
  final bool isTv;
  const AppState({super.key, required this.isTv});

  @override
  Widget build(BuildContext context) {
   

   // windowManager.setAspectRatio(MediaQuery.of(context).size.width/MediaQuery.of(context).size.height);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GeneroProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => MoviesProviders(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
          lazy: false,
        ),
      ],
      child:  MyApp(isTV: isTv,),
    );
  }
}

class MyApp extends StatefulWidget {
  final bool isTV;
  const MyApp({super.key, required this.isTV});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  


 
  @override
  Widget build(BuildContext context) {
   
    final prefs = PreferenciasUsuario();
    
    return ProviderP(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return Container(
              child: AnimatedSplashScreen(
                splashIconSize: 400,
                duration: 4400,
                splash: const Image(
                  image: AssetImage('assets/splash.gif'),
                  fit: BoxFit.cover,
                ),

                //loguinscreen()
                nextScreen:(widget.isTV)?const TVLoginScreen():LoginScreen(),
                //nextScreen: homeScreen2('nada'),
                // nextScreen: MovieScreen3(),
                
                splashTransition: SplashTransition.fadeTransition,
                pageTransitionType: PageTransitionType.fade,
                backgroundColor: const Color.fromARGB(255, 9, 0, 0),
              ),
            );
          },
        ),
        title: 'Peliculas',
        routes: {
          'prueba': (_) => const HomeSreen(),
          'settings': (_) => const SettingsScreen(),
          'register': (_) => RegisterScreen(),
          'login': (_) => const LoginScreen(),
          'movie_screen': (_) => const Peli(),
        },
        theme: ThemeData.light().copyWith(
          appBarTheme:
              const AppBarTheme(color: Color.fromARGB(255, 10, 10, 12)),
              scrollbarTheme: ScrollbarThemeData(
                
  interactive: true,
  thumbVisibility:MaterialStatePropertyAll(Platform.isWindows),
  radius: const Radius.circular(20.0),
  thumbColor: MaterialStateProperty.all(
      Colors.red[400]),
  thickness: MaterialStateProperty.all(15.0),
  minThumbLength: 100,
),


        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          ClassLocalizations.delegate
        ],
        supportedLocales: ClassLocalizations.delegate.supportedLocales,
      ),
    );
  }

  
}
