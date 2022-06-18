import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_app/controllers/api_controller.dart';
import 'package:movie_app/helpers/constants.dart';
import 'package:movie_app/views/search_view.dart';
import 'package:movie_app/widgets/buttons/floating_action_button.dart';
import 'package:movie_app/widgets/slides/favorite_movies.dart';
import 'package:movie_app/widgets/slides/popular_tv_shows.dart';
import 'package:movie_app/widgets/slides/tv_airing_today.dart';
import 'package:movie_app/widgets/slides/now_playing_movies.dart';
import 'package:movie_app/widgets/slides/popular_movies.dart';
import 'package:movie_app/widgets/slides/recommended_movies.dart';
import 'package:movie_app/widgets/slides/similar_movies.dart';
import 'package:movie_app/widgets/slides/top_rated_movies.dart';
import 'package:movie_app/widgets/slides/trending_movies.dart';
import 'package:movie_app/widgets/slides/up_coming_movies.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

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

  @override
  void initState() {
    fetchList();
    print(33);
    InternetConnectionChecker().onStatusChange.listen((status) {
      con.hasInternet = status == InternetConnectionStatus.connected;
      setState(() {
       con.hasInternet = con.hasInternet;
      });
      con.checkInternetConnection();
    });
    con.loadMovies();
    con.getMyList();
    ll;
    print(con.myList);
    super.initState();
  }
  List<String> newList = [];

  fetchList() async {
    ll = await con.getMyList();

    var i = await con.getMyList();
    setState(() {
      newList = i;
    });
    print(newList);
  }

  @override
  Widget build(BuildContext context) {
    fetchList();
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
          body: Stack(
              clipBehavior: Clip.hardEdge,
              alignment: Alignment.center,
              children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.6, 0.4],
                            tileMode: TileMode.repeated,
                            colors: [Colors.brown.withOpacity(0.4), Colors.black])
                    )),
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.black
                    )),
                  SingleChildScrollView(
                    child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                const SizedBox(
                                  height: 360,
                                  width: double.infinity,
                                  // child: ClipRRect(
                                  //   child: Image.network('https://image.tmdb.org/t/p/w500'
                                  //       + popularMovies[0]['poster_path'], fit: BoxFit.cover,),
                                  // ),
                                ),
                                Positioned(
                                  bottom: 2,
                                  left: 50,
                                  right: 50,
                                  child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 60),
                                          child: Text(appName, style: appBarTextStyle)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Column(children: [
                                              InkWell(
                                                onTap: () => {
                                                  setState(() {
                                                    con.tapped = true;
                                                    con.tappedOnce++;
                                                  }),
                                                  con.addMovie(context, '2').then((value) =>
                                                      setState(() {
                                                        con.myList.addAll(value);
                                                      }))},
                                                child: con.tappedOnce == 2 && con.tapped == true ? const Icon(Icons.check,
                                                  size: 30, color: Colors.white)
                                                    : con.tappedOnce == 3 ? const Icon(Icons.add, size: 30,
                                                    color: Colors.white) : const Icon(Icons.add, size: 30,
                                                    color: Colors.white)),
                                              Text('My List', style: titleTextStyle,)
                                            ],),
                                            const SizedBox(width: 35,),
                                            ElevatedButton(onPressed: () => con.addMovieItem(),
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.white,
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 7, horizontal: 20),
                                                onSurface: Colors.black54),
                                                child: Row(children: const [
                                                  Icon(Icons.play_arrow_rounded, size: 35, color: Colors.black,),
                                                  Text("Play", style: TextStyle(color: Colors.black,
                                                      fontSize: 17)),
                                                ],)),
                                            const SizedBox(width: 35,),
                                            Column(children: [
                                              const Icon(Icons.info_outline, size: 30, color: Colors.white,),
                                              Text('Info', style: titleTextStyle,)
                                            ],),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            /// Favorite Movies View
                            // if(con.myList.isEmpty) ... [],
                            // if(myFavoriteMovies.isNotEmpty) ... [],
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 6,
                                  right: 5, bottom: 3),
                              child: Text("My List", style: listTextStyle)),
                            FavoriteMovieList(favoriteList: ll),
                            /// Popular Movies View
                            Padding(
                              padding: const EdgeInsets.only(top: 30, left: 6,
                                  right: 5, bottom: 3),
                              child: Text("Popular on EmmyFlix", style: listTextStyle)),
                            PopularMovies(popularMovies: con.popularMovies),
                            /// Trending Now View
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 6,
                                  right: 5, bottom: 3),
                              child: Text("Trending Now", style: listTextStyle)),
                            TrendingMovieList(trending: con.trendingMovies),
                            /// Similar Movies
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 6,
                                  right: 5, bottom: 3),
                              child: Text("Similar to what you've watched", style: listTextStyle,),),
                            SimilarMoviesList(similarMovies: con.similarMovies,),
                            /// Recommended Movies View
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 6,
                                  right: 5, bottom: 3),
                              child: Text("Recommended Movies", style: listTextStyle)),
                            RecommendedMoviesList(recommended: con.recommendedMovies,),
                            /// TopRated Movies View
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 6,
                                  right: 5, bottom: 3),
                              child: Text("Top Rated Movies", style: listTextStyle,),),
                            TopRatedMovies(topRated: con.topRatedMovies,),
                            /// UpComing TV Shows
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 6,
                                  right: 5, bottom: 3),
                              child: Text("UpComing TV Shows", style: listTextStyle,),),
                            UpComingMovies(upComing: con.upComingTvShows),
                            /// Tv Airing Today
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 6,
                                  right: 5, bottom: 3),
                              child: Text("Tv Airing Today", style: listTextStyle)),
                            TvAiringTodayList(latest: con.tvAiringToday,),
                            /// Now Playing Movies
                            Padding(
                                padding: const EdgeInsets.only(top: 20, left: 6,
                                    right: 5, bottom: 3),
                                child: Text("Now Playing Movies", style: listTextStyle)),
                            NowPlayingMoviesList(nowPlaying: con.nowPlaying),
                            /// Popular Tv Shows
                            Padding(
                                padding: const EdgeInsets.only(top: 20, left: 6,
                                    right: 5, bottom: 3),
                                child: Text("Popular Tv Shows", style: listTextStyle)),
                            PopularTvShows(popularTvShows: con.popularTvShows,),
                            const SizedBox(height: 100,)
                          ],),
                  ),
                    ],),
    );
  }
}
