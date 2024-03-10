

import 'package:flutter/material.dart';
import 'package:yml/generated/l10n.dart';
import 'package:yml/models/route_animation.dart';
import 'package:yml/providers/user_provider.dart';
import 'package:yml/screens/TV_screens/HomeScreen.dart';
import 'package:yml/screens/TV_screens/login_screen.dart';


//import 'package:provider/provider.dart';
import 'package:yml/screens/screens/HomeScreen.dart';
import 'package:yml/search/search_delegate.dart';
import 'package:yml/src/preferencias_usuario.dart';
import 'package:yml/widgets/raw_listener.dart';



final prefs = PreferenciasUsuario();

class TVMenuDrawer extends StatefulWidget {
  final String Usuario;
  const TVMenuDrawer({super.key, required this.Usuario});

  @override
  State<TVMenuDrawer> createState() => _TVMenuDrawerState();
}

class _TVMenuDrawerState extends State<TVMenuDrawer> {
  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    //final moviesProviders = Provider.of<MoviesProviders>(context);
    //final size = MediaQuery.of(context).size;
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
            ShortcutController(
              focusNode: FocusNode(),
              widget: ListTile(
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
            ),
            ShortcutController(
              focusNode: FocusNode(),
              widget: ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.red,
                  ),
                  title: Text(
                    ClassLocalizations.of(context).home,
                    style: const TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  onTap: () {
                    TVHomeSreen(Usuario:widget.Usuario,);
                  }),
            ),
            
                ShortcutController(
                  focusNode: FocusNode(),
                  widget: ListTile(
                      
                  title: Text(ClassLocalizations.of(context).Cerrar,style: const TextStyle(fontSize: 16, color: Colors.white70),),
                  leading: const Icon(Icons.exit_to_app,color: Colors.red,),
                  onTap: () {
                    UserProvider().Deletedevice(widget.Usuario,prefs.model, prefs.deviceId).then((value) => Navigator.pop(context));
                    prefs.password = '';
                    prefs.usuario = '';
                    prefs.Token='';
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      crearRuta(const TVLoginScreen(), const Duration(milliseconds: 300)),
                    );
                  }
                  
                ),
                ),                
          ],
        ),
      ),
    );
  }
}
