import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Peli extends StatefulWidget {
  const Peli({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PeliState createState() => _PeliState();
}

class _PeliState extends State<Peli> {
  late VideoPlayerController _videoPlayerController;
  bool startedPlaying = false;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.network(
      // aqui va el url del video de la peli q se va a pasar por parametro
      'https://visuales.uclv.cu/Peliculas/Extranjeras/1950s/1952/1952_Otelo/Othello.1952.720p.BluRay.x264.YIFY.mp4',
    );

    _videoPlayerController.setLooping(false);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<bool> started() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.play();
    startedPlaying = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(221, 15, 14, 14),
      child: Center(
        child: FutureBuilder<bool>(
          future: started(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data ?? false) {
              return AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: Container(
                  color: Colors.black,
                  child: AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        GestureDetector(
                            onTap: () {
                              _videoPlayerController.value.isPlaying
                                  ? _videoPlayerController.pause()
                                  : _videoPlayerController.play();
                            },
                            child: VideoPlayer(_videoPlayerController)),
                        ClosedCaption(
                            text: _videoPlayerController.value.caption.text),
                        VideoProgressIndicator(_videoPlayerController,
                            allowScrubbing: true),
                        Center(
                          child: IconButton(
                              onPressed: () {
                                _videoPlayerController.value.isPlaying
                                    ? _videoPlayerController.pause()
                                    : _videoPlayerController.play();
                              },
                              icon: const Icon(Icons.play_circle_outlined)),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              // aqui va el logo cargando en un cotainer
              return Container(
                child: const Image(image: AssetImage('assets/logo.gif')),
              );
            }
          },
        ),
      ),
    );
  }
}
