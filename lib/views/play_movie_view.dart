import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/helpers/constants.dart';
import 'package:tmdb_api/tmdb_api.dart';

class PlayMovieView extends StatefulWidget {
  final String name, description, bannerUrl, posterUrl, vote, launchOn,
      language, popularity, sessionId;
  const PlayMovieView({Key? key, required this.name, required this.description,
    required this.bannerUrl, required this.posterUrl, required this.vote,
    required this.launchOn, required this.language, required this.popularity,
    required this.sessionId}) : super(key: key);

  @override
  State<PlayMovieView> createState() => _PlayMovieViewState();
}

class _PlayMovieViewState extends State<PlayMovieView> {

  /// Create Favorite List
  List myFavoriteMovies = [];

  TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true
      ));

  // createFavoriteMovieList() async {
  //   Map favoriteResults = await tmdbWithCustomLogs.v3.lists.createList
  //     (widget.sessionId, widget.name, widget.description);
  //   setState(() {
  //     myFavoriteMovies = favoriteResults['results'];
  //   });
  // }

  String sessionId = "";
  String name = "";
  String description = "";
  String listId = "";
  int? mediaId;

  List myFavoriteMoviesList = [];

  addMovieToList() async {
    Map favListResults = await tmdbWithCustomLogs.v3.lists.createList
      (sessionId, name, description);
    Map favoriteMovieResults = await tmdbWithCustomLogs.v3.lists
        .addItem(sessionId, listId, mediaId);
    setState(() {
      myFavoriteMoviesList = favListResults['results'];
      myFavoriteMovies = favoriteMovieResults['results'];
    });
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
                  + widget.bannerUrl),
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
                            child: IconButton(onPressed: () => addMovieToList(), icon: const Icon
                              (Icons.add, color: Colors.white, size: 30,)),
                          )]),
                  ),
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
                                + widget.posterUrl, fit: BoxFit.cover,))),
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
                            Text(widget.language, style: descTextStyle,),
                            VerticalDivider(color: Colors.white.withOpacity(0.6), thickness: 2,),
                            Text("Action, Sci-Fi", style: descTextStyle,),
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
                        child: ElevatedButton(onPressed: () {},
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
