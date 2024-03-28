import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yml/widgets/video_local.dart';

class VideoSelecter extends StatelessWidget {
  const VideoSelecter({
    super.key, required this.genreID, required this.isTVorWidows,
    
  });
 final bool  isTVorWidows;
final String genreID;

  @override
  Widget build(BuildContext context) {
    Future<bool> assetExists(String path) async{
 try{
   await rootBundle.loadString(path);
   return true;
 } catch (e){
   return false;
 }
}
   Future<String> dameImagen(String ruta)  async {
    String path = 'images/nocolor.png';
bool fileExists = await assetExists(path);
if (fileExists) {
    return ruta;
}else{
    return 'assets/icon.png';
}



   }
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.2,
      child: FutureBuilder(
        future: dameImagen('assets/$genreID.gif'),
        builder:(context, snapshot) {
          if (snapshot.hasData) {
          return  FadeInImage(
                fit: BoxFit.fill,
                placeholder: const AssetImage(
                  'assets/icon.png',
            
                ),
                image: AssetImage( snapshot.data!),
                  
                // image: AssetImage('assets/icon.png'),
                //NetworkImage(moviesProviders.Estrenos.first.posterPath),
                imageErrorBuilder: (context, error, stackTrace) => const Image(
                  image: AssetImage('assets/icon.png'),
                  fit: BoxFit.contain,
                ),
              );
          }else {
           return const Center(child: CircularProgressIndicator(),);
          }
        }, 
      ),
    );}
}

class VideoHorizontal extends StatefulWidget {
  const VideoHorizontal({
    super.key, required this.genreId, required this.aspectRatio,
  
  });

  final String genreId;
 // final bool estaVirado;
  final double aspectRatio;

  @override
  State<VideoHorizontal> createState() => _VideoHorizontalState();
}

class _VideoHorizontalState extends State<VideoHorizontal> {
  @override
  Widget build(BuildContext context) {
  
    
  final String ruta ='assets/video/${widget.genreId}.mp4';
  return SizedBox(
  height: 150,
  width: 100,
  child: VideoWidget(route: ruta, aspectRatio: widget.aspectRatio),
    );
      }
}