import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'dart:io' show Platform;

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({Key? key}) : super(key: key);

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _playerController;

  @override
  void initState() {
    super.initState();
    if(Platform.isIOS) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    }else if(Platform.isAndroid){
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    }
    _playerController = VideoPlayerController.network
      ('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) => {
        setState(() {})
      });
  }

  @override
  void dispose() {
    super.dispose();
    _playerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _playerController.value.isPlaying
                ? _playerController.pause()
                : _playerController.play();
          });
        }, child: Icon(_playerController.value.isPlaying
            ? Icons.pause : Icons.play_arrow)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: _playerController.value.isInitialized
                  ? AspectRatio(aspectRatio: _playerController.value.aspectRatio,
                child: VideoPlayer(_playerController),)
                  : Container()),
          Positioned(top: 30, left: 20,
              child: _playerController.value.isPlaying
              ? Container() : BackButton(onPressed: () {
                Navigator.pop(context);
                SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown]);
              },
                  color: Colors.black)),
        ],
      )
    );
  }
}
