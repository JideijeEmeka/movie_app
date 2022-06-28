import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({Key? key}) : super(key: key);

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: BackButton(onPressed: () => {
        Navigator.pop(context),
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        },
        color: Colors.black,),
      ),
      body: Container(
        child: Center(child: Text('Breast'))
      ),
    );
  }
}
