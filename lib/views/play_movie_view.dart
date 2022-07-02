import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/controllers/api_controller.dart';
import 'package:movie_app/helpers/constants.dart';
import 'package:movie_app/views/video_player_view.dart';
import 'package:movie_app/widgets/snack_bar_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class PlayMovieView extends StatefulWidget {
  final String name, description, bannerUrl, posterUrl, vote, launchOn,
      language, popularity, movieId;
  const PlayMovieView({Key? key, required this.name, required this.description,
    required this.bannerUrl, required this.posterUrl, required this.vote,
    required this.launchOn, required this.language, required this.popularity,
    required this.movieId}) : super(key: key);

  @override
  _PlayMovieViewState createState() => _PlayMovieViewState();
}

class _PlayMovieViewState extends StateMVC<PlayMovieView> {
  _PlayMovieViewState() : super(ApiServiceController()) {
    con = controller as ApiServiceController;
  }

  late ApiServiceController con;
  @override
  void initState() {
    //con.myList = favList;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/w500"
                  + widget.bannerUrl.toString()),
              fit: BoxFit.fill)
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Column(
                children: [
                  Container(height: 30, color: Colors.black.withOpacity(0.3),),
                  Container(
                    height: 60,
                    color: Colors.black.withOpacity(0.3),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: ImageIcon(AssetImage("assets/images/back_button.png"),
                                  color: Colors.white),
                            ),
                          ),
                          Text("Overview", style: appBarTextStyle),
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: !myOwnList.contains(widget.movieId) ?
                            /// Show add icon if movie is not yet added to favorite
                            IconButton(onPressed: () async {
                              String result = await con.addMovieToList(widget.movieId);
                                ScaffoldMessenger.of(context).showSnackBar(snackBar(message: result));
                              myOwnList.insert(0, widget.movieId);
                              debugPrint('$myOwnList');
                              setState(() { });
                            },
                                icon: const Icon(Icons.add, size: 30,
                                    color: Colors.white))
                            /// Show check icon if movie already added to favorite
                                : IconButton(onPressed: () async {
                              String result = await con.removeMovieFromList(widget.movieId);
                              ScaffoldMessenger.of(context).showSnackBar(snackBar(message: result));
                              myOwnList.remove(widget.movieId);
                              setState(() { });
                            },
                                icon: const Icon(Icons.check, size: 30,
                                    color: Colors.white))
                          )])),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: Center(child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                            child: Image.network("https://image.tmdb.org/t/p/w500"
                                + widget.posterUrl.toString(), fit: BoxFit.cover,))),
                      ),
                    ],),
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(widget.name, style: appBarTextStyle,),
                      ),
                      const SizedBox(height: 5,),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(widget.language.toUpperCase(), style: descTextStyle,),
                            VerticalDivider(color: Colors.white.withOpacity(0.6), thickness: 2,),
                            Text(widget.movieId, style: descTextStyle,),
                            VerticalDivider(color: Colors.white.withOpacity(0.6), thickness: 2,),
                            Text(widget.launchOn, style: descTextStyle,),
                            VerticalDivider(color: Colors.white.withOpacity(0.6), thickness: 2,),
                            Text('${widget.popularity}%', style: descTextStyle,),
                            VerticalDivider(color: Colors.white.withOpacity(0.6), thickness: 2,),
                            const Icon(Icons.star, color: Colors.yellow, size: 20,),
                            const SizedBox(width: 3,),
                            Text(widget.vote, style: descTextStyle,),
                            VerticalDivider(color: Colors.white.withOpacity(0.6), thickness: 2,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 10),
                        child: Text("Story line", style: appBarTextStyle,),
                      ),
                      Text(widget.description, style: descTextStyle),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 30),
                        child: ElevatedButton(onPressed: () => {
                          pushNewScreen(context, screen: const VideoPlayerView(),
                          withNavBar: false)
                        },
                            style: ElevatedButton.styleFrom(
                                textStyle: titleTextStyle,
                                primary: gradientRedColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 10)),
                            child: const Text("Watch")),
                      )
                    ],),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
