import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_app/controllers/api_controller.dart';
import 'package:movie_app/helpers/constants.dart';
import 'package:movie_app/views/search_view.dart';
import 'package:movie_app/widgets/buttons/floating_action_button.dart';
import 'package:movie_app/widgets/favorite_movies.dart';
import 'package:movie_app/widgets/latest_movies.dart';
import 'package:movie_app/widgets/popular_tv_shows.dart';
import 'package:movie_app/widgets/top_rated_movies.dart';
import 'package:movie_app/widgets/trending_movies.dart';
import 'package:movie_app/widgets/up_coming_movies.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tmdb_api/tmdb_api.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends StateMVC<HomeView> {
  _HomeViewState() : super(ApiServiceController()) {
    con = controller as ApiServiceController;
  }

  late ApiServiceController con;
  bool hasInternet = false;
  ConnectivityResult result = ConnectivityResult.none;

  @override
  void initState() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      hasInternet = status == InternetConnectionStatus.connected;
      setState(() {
       hasInternet = hasInternet;
      });
      checkInternetConnection();
    });
    loadMovies();
    super.initState();
  }

  checkInternetConnection() async {
    hasInternet = await InternetConnectionChecker().hasConnection;
    result = await Connectivity().checkConnectivity();
    final color = hasInternet ? Colors.green : Colors.red;
    final text = hasInternet ? 'Internet Connected' : 'No Internet';
    final wifiText = hasInternet ? 'Wifi Connected' : 'No Wifi Internet';
    final mobileText = hasInternet ? 'Internet Connected' : 'No Mobile Internet';

    if(result == ConnectivityResult.mobile) {
      showSimpleNotification(
          Text(mobileText, style: titleTextStyle),
          background: color);
    }else if(result == ConnectivityResult.wifi) {
      showSimpleNotification(
          Text(wifiText, style: titleTextStyle),
          background: color);
    }else {
      showSimpleNotification(
          Text(text, style: titleTextStyle),
          background: color);
    }
  }

  String sessionId = "";
  String name = "";
  String description = "";
  String listId = "";

  /// Load movies
  List trendingMovies = [];
  List topRatedMovies = [];
  List latestMovies = [];
  List popularTvShows = [];
  List upComingTvShows = [];
  List myFavoriteMoviesList = [];
  List myFavoriteMovies = [];

  TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true
      ));

  loadMovies() async {
    Map trendingResults = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topRatedResults = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map popularTvResults = await tmdbWithCustomLogs.v3.movies.getPopular();
    Map upComingTvResults = await tmdbWithCustomLogs.v3.movies.getUpcoming();
    Map latestMoviesResults = await tmdbWithCustomLogs.v3.movies.getLatest();
    setState(() {
      trendingMovies = trendingResults['results'];
      topRatedMovies = topRatedResults['results'];
      popularTvShows = popularTvResults['results'];
      upComingTvShows = upComingTvResults['results'];
      latestMovies = latestMoviesResults['results'];
      // myFavoriteMovies = favoriteMovieResults['results'];
    });
  }

  addMovieToList(int? mediaId) async {
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          flexibleSpace: Container(
            color: Colors.black.withOpacity(0.3),
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
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.3, 0.7],
                            tileMode: TileMode.repeated,
                            colors: [Colors.brown.withOpacity(0.4), Colors.black])
                    )),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3)
                    )),
                  SingleChildScrollView(
                    child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 200),
                            Center(
                              child: Text(appName.toUpperCase(),
                                style: headerTextStyle, textAlign: TextAlign.center)),
                            const SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Column(children: [
                                  IconButton(onPressed: () {},
                                      icon: const Icon(Icons.message, size: 30,
                                        color: Colors.white,)),
                                  Text("My List", style: normalTextStyle,),
                                ],),
                                ElevatedButton(onPressed: () =>
                                    {},
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 7, horizontal: 25),
                                      onSurface: Colors.black54),
                                    child: Row(children: const [
                                      Icon(Icons.add, size: 30, color: Colors.black,),
                                      Text("Create New List", style: TextStyle(color: Colors.black,
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
                            /// Favorite Movies View
                            if(myFavoriteMovies.isEmpty) ... [],
                            if(myFavoriteMovies.isNotEmpty) ... [
                              Padding(
                                padding: const EdgeInsets.only(top: 20, left: 6,
                                    right: 5, bottom: 10),
                                child: Text("My List", style: listTextStyle,),),
                              FavoriteMovieList(favoriteList: myFavoriteMovies),
                            ],
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
                            /// UpComing TV Shows
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 6,
                                  right: 5, bottom: 10),
                              child: Text("UpComing TV Shows", style: listTextStyle,),),
                            UpComingMovies(upComing: upComingTvShows),
                            /// Latest Movies
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 6,
                                  right: 5, bottom: 10),
                              child: Text("Latest Movies", style: listTextStyle)),
                            LatestMovies(latest: latestMovies),
                            ///
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
                                    return const FavoriteMovieList(favoriteList: [],);
                              }),
                            ),
                            const SizedBox(height: 30,)
                          ],),
                  ),
                ]),
    );
  }
}
