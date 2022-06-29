import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

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
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    _playerController = VideoPlayerController.network
      ('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) => {
        setState(() {

        })
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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: _playerController.value.isInitialized
            ? AspectRatio(aspectRatio: _playerController.value.aspectRatio,
          child: VideoPlayer(_playerController),)
            : Container())
    );
  }
}
