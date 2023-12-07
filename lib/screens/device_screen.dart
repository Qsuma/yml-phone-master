
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yml/models/device.dart';
import 'package:yml/providers/user_provider.dart';
import 'package:yml/screens/details_screens.dart';
import 'package:yml/widgets/alarms_dialog.dart';


class Dispositivos extends StatefulWidget {
  final String Usuario ;

  Dispositivos({super.key, required this.Usuario});

  @override
  State<Dispositivos> createState() => _DispositivosState();
}

class _DispositivosState extends State<Dispositivos> {


  @override
  Widget build(BuildContext context) {
List<dynamic>devices = jsonDecode(prefs.Devices);
String device1='';
String deviceID1='';
String device2='';
String deviceID2='';
String device3='';
String deviceID3='';
int i = 1;
for(var device in devices){
  
  if(i==1){
    device1 =device['device'];
    deviceID1=device['device_id'];
    }
  if(i==2){
    deviceID2=device['device_id'];
    device2 =device['device'];
    }
  if(i==3){
    deviceID3=device['device_id'];
    device3 =device['device'];
    }
  i++;

 
}

    return  Scaffold(
        appBar: AppBar(
          title:Text('Pantalla de Dispositivos'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width:MediaQuery.of(context).size.width*0.9,
                
                color: Colors.red[900],
child: Center(child: Text('Demasiados dispositivos Conectados',textAlign: TextAlign.center,style: TextStyle(fontSize: 25,color: Colors.white),)),

              ),
              
              IconRow(icon: Icons.tv_sharp, device:device1 ,deviceId: deviceID1,Usuario: widget.Usuario),
              IconRow(icon: Icons.tv_sharp, device:device2,deviceId: deviceID2,Usuario: widget.Usuario),
              IconRow(icon: Icons.tv_sharp, device:device3,deviceId: deviceID3,Usuario: widget.Usuario,),
            ],
          ),
        ),
      );
  }
}

class IconRow extends StatefulWidget {
  final String Usuario;
  final IconData icon;
  final String device;
  final String deviceId;

  IconRow({required this.icon, required this.device, required this.deviceId, required this.Usuario});

  @override
  State<IconRow> createState() => _IconRowState();
}

class _IconRowState extends State<IconRow> {
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            widget.icon,
            size: 50.0,
          ),
          SizedBox(width: 20.0),
          ElevatedButton(
            onPressed: () {
                UserProvider().Deletedevice(widget.Usuario,widget.device, widget.deviceId).then((value) => Navigator.pop(context));
              //
            },
            child: Text(widget.device),
          ),
        ],
      ),
    );
  }
}