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
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: _playerController.value.isInitialized
                  ? AspectRatio(aspectRatio: _playerController.value.aspectRatio,
                child: VideoPlayer(_playerController),)
                  : Container()),
          Positioned(top: 20, left: 2,
              child: _playerController.value.isPlaying
              ? Container() : BackButton(onPressed: () {
                Navigator.pop(context);
                SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown]);
              },
                  color: Colors.red)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                /// Skip backwards button
              IconButton(
                onPressed: () {
                setState(() {
                  _playerController.value.isPlaying
                      ? _playerController.pause()
                      : _playerController.play();
                });
              }, icon: const Icon(Icons.skip_previous), iconSize: 80, color: Colors.red,),
              /// Play button
              IconButton(onPressed: () {
                setState(() {
                  _playerController.value.isPlaying
                      ? _playerController.pause()
                      : _playerController.play();
                });
              }, icon: Icon(_playerController.value.isPlaying
                  ? Icons.pause : Icons.play_arrow), iconSize: 80, color: Colors.red,),
              /// Skip forward button
              IconButton(
                onPressed: () {
                  _playerController.seekTo(const Duration(seconds: 1));
                  setState(() {});
              }, icon: const Icon(Icons.skip_next), iconSize: 80, color: Colors.red,)
            ],)
          ],)
        ],
      )
    );
  }
}
