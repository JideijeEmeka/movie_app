import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_app/controllers/connectivity_controller.dart';
import 'package:movie_app/helpers/constants.dart';
import 'package:movie_app/views/search_view.dart';
import 'package:movie_app/widgets/buttons/floating_action_button.dart';
import 'package:movie_app/widgets/favorite_movie_list_widget.dart';
import 'package:movie_app/widgets/popular_tv_shows.dart';
import 'package:movie_app/widgets/top_rated_movies.dart';
import 'package:movie_app/widgets/trending_movies.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tmdb_api/tmdb_api.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends StateMVC<HomeView> {
  _HomeViewState() : super(ConnectivityServiceController()) {
    con = controller as ConnectivityServiceController;
  }

  late ConnectivityServiceController con;

  @override
  void initState() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      con.hasInternet = status == InternetConnectionStatus.connected;
      setState(() {
        con.hasInternet = con.hasInternet;
      });
      con.checkInternetConnection();
    });
    loadMovies();
    super.initState();
  }

  /// Load movies
  List trendingMovies = [];
  List topRatedMovies = [];
  List popularTvShows = [];

  String apiKey = "2a209b9033ad19c74ec7ab61c4cd582e";
  String readAccessToken =  "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyYTIwOWI5MDMzYWQ"
      "xOWM3NGVjN2FiNjFjNGNkNTgyZSIsInN1YiI6IjYyYTBjMGJkN2UxMmYwNmUwNzdhNzk1MC"
      "IsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.nomF8AyiMxmk7R4nXfVmZ-"
      "j1LxM9zeW8qHhuN00iKaA";

  loadMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKey, readAccessToken),
        logConfig: const ConfigLogger(
            showLogs: true,
            showErrorLogs: true
        ));
    Map trendingResults = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topRatedResults = await tmdbWithCustomLogs.v3.tv.getTopRated();
    Map popularTvResults = await tmdbWithCustomLogs.v3.tv.getPopular();
    setState(() {
      trendingMovies = trendingResults['results'];
      topRatedMovies = topRatedResults['results'];
      popularTvShows = popularTvResults['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 85, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              TextButton(onPressed: () {},
                  child: Text("TV Shows", style: titleTextStyle)),
              TextButton(onPressed: () {},
                  child: Text("Movies", style: titleTextStyle)),
              TextButton(onPressed: () {},
                  child: Text("Categories", style: titleTextStyle))])),
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Image.asset("assets/images/logo.png"),
          ),
          actions: [
            IconButton(onPressed: () =>
                pushNewScreen(context, screen: const SearchView()),
                padding: const EdgeInsets.only(right: 10),
                icon: const Icon(Icons.search_rounded, color: Colors.white,
                size: 30,)),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              width: 30,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                color: Colors.white
              ),
            )
          ],
        ),
      ),
          floatingActionButton: floatButton(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          body: Stack(children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/movie_img.png"),
                    fit: BoxFit.fill),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.3, 0.7],
                      tileMode: TileMode.repeated,
                      colors: [Colors.transparent.withOpacity(0.2), Colors.black])
              ),
            ),
            SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 250),
                    Center(
                      child: Text("black hawk\n down".toUpperCase(),
                        style: headerTextStyle, textAlign: TextAlign.center)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Column(children: [
                          IconButton(onPressed: () {},
                              icon: const Icon(Icons.add, size: 30,
                                color: Colors.white,)),
                          Text("My List", style: normalTextStyle,),
                        ],),
                        ElevatedButton(onPressed: () async {},
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 25),
                              onSurface: Colors.black54),
                            child: Row(children: const [
                              Icon(Icons.play_arrow, size: 30, color: Colors.black,),
                              Text("Play", style: TextStyle(color: Colors.black,
                                  fontSize: 17)),
                            ],)),
                          Column(children: [
                            IconButton(onPressed: () {},
                                icon: const Icon(Icons.info_outline, size: 30,
                                  color: Colors.white,)),
                            Text("Info", style: normalTextStyle,),
                          ],),
                      ],),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 6,
                          right: 15, bottom: 10),
                      child: Text("My List", style: listTextStyle,),),
                    SizedBox(
                      height: 170,
                      child: ListView.builder(
                        shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const ScrollPhysics(),
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            return const FavoriteMovieList();
                      }),
                    ),
                    /// Popular Movies View
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 6,
                          right: 5, bottom: 10),
                      child: Text("Popular on EmmyFlix", style: listTextStyle,),),
                    PopularTvShows(popularTvShows: popularTvShows,),
                    /// Trending Now View
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 6,
                          right: 5, bottom: 10),
                      child: Text("Trending Now", style: listTextStyle)),
                    TrendingMovieList(trending: trendingMovies),
                    /// TopRated Movies View
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 6,
                          right: 5, bottom: 10),
                      child: Text("Top Rated Movies", style: listTextStyle,),),
                    TopRatedMovies(topRated: topRatedMovies,),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 6,
                          right: 5, bottom: 10),
                      child: Text("Exciting International TV Shows", style: listTextStyle,),),
                    SizedBox(
                      height: 170,
                      child: ListView.builder(
                        shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const ScrollPhysics(),
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            return const FavoriteMovieList();
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 6,
                          right: 5, bottom: 10),
                      child: Text("Action Movies", style: listTextStyle,),),
                    SizedBox(
                      height: 170,
                      child: ListView.builder(
                        shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const ScrollPhysics(),
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            return const FavoriteMovieList();
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 6,
                          right: 5, bottom: 10),
                      child: Text("Vampires & Werewolves", style: listTextStyle)),
                    SizedBox(
                      height: 170,
                      child: ListView.builder(
                        shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const ScrollPhysics(),
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            return const FavoriteMovieList();
                      }),
                    ),
                    const SizedBox(height: 30,)
                  ],),
            )
          ]),
    );
  }
}
