import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/helpers/constants.dart';
import 'package:video_player/video_player.dart';
import 'dart:io' show Platform;

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({Key? key}) : super(key: key);

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _playerController;

  // late DateTime movieDuration;

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
    // movieDuration = DateTime.parse(_playerController.value.duration.toString());
    // _playerController.value.isPlaying
  }

  @override
  void dispose() {
    super.dispose();
    _playerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final formattedMovieDuration = DateFormat('hh:mm').format(movieDuration);

    return Scaffold(
      body: Stack(
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
                  color: Colors.white)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80,),
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
              }, icon: const Icon(Icons.skip_previous), iconSize: 80, color: Colors.white,),
              /// Play button
              IconButton(onPressed: () {
                setState(() {
                  _playerController.value.isPlaying
                      ? _playerController.pause()
                      : _playerController.play();
                });
              }, icon: Icon(_playerController.value.isPlaying
                  ? Icons.pause : Icons.play_arrow), iconSize: 80, color: Colors.white,),
              /// Skip forward button
              IconButton(
                onPressed: () {
                  _playerController.seekTo(const Duration(seconds: 1));
                  setState(() {});
              }, icon: const Icon(Icons.skip_next), iconSize: 80, color: Colors.white,)
            ],),
              /// Video Progress Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Container(
                    margin: const EdgeInsets.only(left: 30, right: 30, top: 80),
                    child: VideoProgressIndicator(_playerController,
                      allowScrubbing: true,
                      colors: const VideoProgressColors(
                          backgroundColor: Colors.white,
                          bufferedColor: Colors.white,
                          playedColor: Colors.red
                      ),
                    ),
                  ),),
                  ///Video Duration
                  Padding(
                    padding: const EdgeInsets.only(top: 80, right: 30),
                    child: Text(_playerController.value.duration.toString(),
                      style: titleTextStyle,),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Screen Lock
                    Row(children: [
                      const FaIcon(FontAwesomeIcons.unlock, color: Colors.white,),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text('Screen Lock', style: titleTextStyle,),
                      )
                    ],),
                    ///Episodes
                    Row(children: [
                      const FaIcon(FontAwesomeIcons.images, color: Colors.white,),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text('Episodes', style: titleTextStyle,),
                      )
                    ],),
                    /// Audio and Subtitles
                    Row(children: [
                      const FaIcon(FontAwesomeIcons.microphone, color: Colors.white,),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text('Audio & Subtitles', style: titleTextStyle,),
                      )
                    ],),
                    /// Next Episode
                    Row(children: [
                      const FaIcon(FontAwesomeIcons.forwardStep, color: Colors.white,),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text('Next Ep.', style: titleTextStyle,),
                      )
                    ],),
                  ],
                ),
              )
          ],)
        ],
      )
    );
  }
}
