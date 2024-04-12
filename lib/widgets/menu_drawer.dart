import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:window_manager/window_manager.dart';
//import 'package:provider/provider.dart';
import 'package:yml/screens/screens/HomeScreen.dart';
import 'package:yml/widgets/raw_listener.dart';

import '../generated/l10n.dart';
import '../models/route_animation.dart';

//import '../providers/movie_providers.dart';
import '../screens/login_screen.dart';
import '../search/search_delegate.dart';
import '../src/preferencias_usuario.dart';

final prefs = PreferenciasUsuario();

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    //final moviesProviders = Provider.of<MoviesProviders>(context);
    //final size = MediaQuery.of(context).size;
   // final ScrollController scrollController;
    if (screensize.width >= 500) {}
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 54, 53, 53).withOpacity(1),
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const Stack(children: [
              // Container(
              //     child: const Image(
              //   image: AssetImage('assets/Icon_wall.jpg'),
              //   fit: BoxFit.cover,
              // )),
              // Center(
              //   widthFactor: 1,
              //   heightFactor: 0.80,
              //   child: DrawerHeader(
              //     // ignore: prefer_const_constructors
              //     decoration: BoxDecoration(
              //       image: DecorationImage(
              //           scale: 12,
              //          image: AssetImage('assets/Icon.png'),
              //          fit: BoxFit.scaleDown),
              //     ),
              //     child: Container(),
              //   ),
              // ),
            ]),
             ListTile(
                  leading: const Icon(
                    Icons.search,
                    color: Colors.red,
                  ),
                  title: Text(
                    ClassLocalizations.of(context).buscar,
                    style: const TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  onTap: () => showSearch(
                      context: context, delegate: movieSearchDelegate())),
            
        //     ListTile(
        //           leading: const Icon(
        //             Icons.home,
        //             color: Colors.red,
        //           ),
        //           title: Text(
        //             ClassLocalizations.of(context).home,
        //             style: const TextStyle(fontSize: 16, color: Colors.white70),
        //           ),
        //           onTap: () {
        //             scrollController.animateTo(
        //   0.0,
        //   duration: const Duration(milliseconds: 500),
        //   curve: Curves.easeInOut,
        // );
        //           }),
            
            
               ListTile(
                      
                  title: Text(ClassLocalizations.of(context).Cerrar,style: const TextStyle(fontSize: 16, color: Colors.white70),),
                  leading: const Icon(Icons.exit_to_app,color: Colors.red,),
                  onTap: () {
                    prefs.Rememberme=false;
                    prefs.password = '';
                    prefs.usuario = '';
                    prefs.Token='';
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      crearRuta(const LoginScreen(), const Duration(milliseconds: 300)),
                    );
                  }
                  
                ),
               

(Platform.isWindows)?ListTile(
                leading: const Icon(
                  Icons.logout_outlined,
                  color: Colors.red,
                ),
                title: Text(
                  ClassLocalizations.of(context).logout,
                  style: const TextStyle(fontSize: 16, color: Colors.white70),
                ),
                onTap: () {
    (Platform.isWindows)?windowManager.close(): SystemNavigator.pop();
  },
                ):Container(),
                
          ],
        ),
      ),
    );
  }
}
