import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../src/preferencias_usuario.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _ModoOscuro;

  final prefs = PreferenciasUsuario();
  @override
  void initState() {
    super.initState();
    _ModoOscuro = true;
  }

  setSelectedRadio(int? value) {
    prefs.Ejemplo = value ?? 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (prefs.ModoOscuro)
          ? const Color.fromARGB(31, 245, 245, 245)
          : const Color.fromARGB(255, 226, 226, 226).withOpacity(1),
      appBar: AppBar(
        backgroundColor: (prefs.ModoOscuro)
            ? const Color.fromARGB(255, 54, 53, 53).withOpacity(1)
            : Colors.indigo[400],
        title: Text(
          ClassLocalizations.of(context).ajustes,
          style: TextStyle(
              fontSize: 24,
              color: (prefs.ModoOscuro) ? Colors.white70 : Colors.black),
        ),
      ),
      //drawer: const MenuDrawer(),
      body: ListView(children: [
        SwitchListTile(
          activeColor: (prefs.ModoOscuro) ? Colors.red : Colors.blue,
          value: _ModoOscuro,
          title: Text(
            ClassLocalizations.of(context).modoOscuro,
            style: TextStyle(
                fontSize: 20,
                color: (prefs.ModoOscuro) ? Colors.white70 : Colors.black),
          ),
          onChanged: (value) {
            setState(() {
              _ModoOscuro = value;
              prefs.ModoOscuro = value;
            });
          },
        ),
        Divider(
          thickness: 0.5,
          color: (prefs.ModoOscuro) ? Colors.red : Colors.blue,
        ),
        Center(
          child: Container(
              child: const Icon(
            Icons.settings,
            size: 200,
            color: Colors.black54,
          )),
        )
        /* Container(
          padding: EdgeInsets.all(5.0),
          child: Text(
            textAlign: TextAlign.start,
            '   Idioma',
            style: TextStyle(
                fontSize: 20,
                color: (prefs.ModoOscuro) ? Colors.white70 : Colors.black),
          ),
        ),
          Divider(
          thickness: 0.5,
          color: (prefs.ModoOscuro) ? Colors.red : Colors.blue,
        ),
        RadioListTile(
          activeColor: (prefs.ModoOscuro) ? Colors.red : Colors.blue,
          value: 1,
          groupValue: _Ejemplo,
          title: Text(
            'Español',
            style: TextStyle(
                fontSize: 20,
                color: (prefs.ModoOscuro) ? Colors.white70 : Colors.black),
          ),
          onChanged: setSelectedRadio,
        ),
        RadioListTile(
            activeColor: (prefs.ModoOscuro) ? Colors.red : Colors.blue,
            value: 2,
            groupValue: _Ejemplo,
            title: Text(
              'English',
              style: TextStyle(
                  fontSize: 20,
                  color: (prefs.ModoOscuro) ? Colors.white70 : Colors.black),
            ),
            onChanged: setSelectedRadio),
        RadioListTile(
            activeColor: (prefs.ModoOscuro) ? Colors.red : Colors.blue,
            value: 3,
            groupValue: _Ejemplo,
            title: Text(
              'Català',
              style: TextStyle(
                  fontSize: 20,
                  color: (prefs.ModoOscuro) ? Colors.white70 : Colors.black),
            ),
            onChanged: setSelectedRadio),
        Divider(
          thickness: 0.5,
          color: (prefs.ModoOscuro) ? Colors.red : Colors.blue,
        ),*/
      ]),
    );
  }
}
