import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/controllers/api_controller.dart';
import 'package:movie_app/helpers/constants.dart';
import 'package:movie_app/helpers/utility.dart';
import 'package:movie_app/views/movies_view.dart';
import 'package:movie_app/views/play_movie_view.dart';
import 'package:movie_app/views/search_view.dart';
import 'package:movie_app/views/tv_shows_view.dart';
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
import 'package:movie_app/widgets/snack_bar_widget.dart';
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
  List<String> newList = [];
  final utility = Utility();

  @override
  void initState() {
    fetchList();
    // InternetConnectionChecker().onStatusChange.listen((status) {
    //   con.hasInternet = status == InternetConnectionStatus.connected;
    //   setState(() {
    //    con.hasInternet = con.hasInternet;
    //   });
    //   con.checkInternetConnection();
    // });
    con.loadMovies().then((_) => shuffleMovies());
    con.loadComingSoonMovies();
    con.discoverMovies();
    con.getTvShows();
    con.getMyList();
    super.initState();
  }

  fetchList() async {
    // con.prefs = await SharedPreferences.getInstance();
    //con.prefs.clear();
    var i = await con.getMyList();
    setState(() {
      newList = i;
    });
    debugPrint('$newList');
  }

  List mainScreenMovies = [];

  shuffleMovies() {
    mainScreenMovies = con.nowPlaying.toSet().toList();
    mainScreenMovies.shuffle();
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
          leading: IconButton(onPressed: () => ScaffoldMessenger.of(context)
              .showSnackBar(snackBar(message: 'This project is owned by EmmyFLix and its copyrighted!')),
            icon: const FaIcon(FontAwesomeIcons.e, color: Colors.red, size: 45)),
          flexibleSpace: Container(
            color: Colors.black.withOpacity(0.3),
              padding: const EdgeInsets.only(top: 85, left: 30, right: 30),
              child: Row( 
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                TextButton(onPressed: () => pushNewScreen(context, screen:
                  TvShowsView(tvShows: con.tvShows), withNavBar: false),
                    child: Text("TV Shows", style: titleTextStyle)),
                TextButton(onPressed: () => pushNewScreen(context, screen:
                  MoviesView(movies: con.movies), withNavBar: false),
                    child: Text("Movies", style: titleTextStyle)),
                TextButton(onPressed: () => ScaffoldMessenger.of(context)
                    .showSnackBar(snackBar(message: 'Coming soon!')),
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
          floatingActionButton: floatButton(() => ScaffoldMessenger.of(context)
              .showSnackBar(snackBar(message: 'Coming soon!')),
              "Play Something Now", const Icon(CupertinoIcons.shuffle)),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          body: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black
                  )
                ),
                  SingleChildScrollView(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          if(mainScreenMovies.isEmpty) ... [],
                          if(mainScreenMovies.isNotEmpty) ... [
                            SizedBox(
                              width: double.infinity,
                              child: ClipRRect(
                                child: Image.network('https://image.tmdb.org/t/p/w500'
                                    + mainScreenMovies[0]['poster_path'], fit: BoxFit.cover),
                              ),
                            ),
                          ],
                        ],
                      ),
                      if(mainScreenMovies.isEmpty) ... [],
                      if(mainScreenMovies.isNotEmpty) ... [
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: const [0.6, 0.7],
                                  tileMode: TileMode.repeated,
                                  colors: [Colors.black.withOpacity(0.8), Colors.black])),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(children: [
                                !myOwnList.contains(mainScreenMovies[0]['id'].toString()) ?
                                IconButton(onPressed: () async {
                                  String result = await con.addMovieToList(mainScreenMovies[0]['id'].toString());
                                  con.getMovieDetails(movieId: int.parse(mainScreenMovies[0]['id']));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar(message: result));
                                  myOwnList.insert(0, mainScreenMovies[0]['id'].toString());
                                  debugPrint('$myOwnList');
                                  setState(() { });
                                }, icon: const Icon(Icons.add, size: 30,
                                    color: Colors.white))
                                    : IconButton(onPressed: () async {
                                  String result = await con.removeMovieFromList(mainScreenMovies[0]['id'].toString());
                                  con.getMovieDetails(movieId: int.parse(mainScreenMovies[0]['id']));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar(message: result));
                                  myOwnList.remove(mainScreenMovies[0]['id'].toString());
                                  setState(() { });
                                },
                                    icon: const Icon(Icons.check, size: 30,
                                        color: Colors.white)),
                                Text('My List', style: titleTextStyle,)
                              ],),
                              const SizedBox(width: 35),
                              ElevatedButton(onPressed: () =>
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snackBar(message: 'Coming soon!')),
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white, backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                                      disabledForegroundColor: Colors.black54.withOpacity(0.12).withOpacity(0.38),
                                      disabledBackgroundColor: Colors.black54.withOpacity(0.12).withOpacity(0.12)),
                                  child: const Row(children: [
                                    Icon(Icons.play_arrow_rounded, size: 35, color: Colors.black,),
                                    Text("Play", style: TextStyle(color: Colors.black,
                                        fontSize: 17)),
                                  ],)),
                              const SizedBox(width: 35,),
                              InkWell(
                                onTap: () =>
                                {
                                  pushNewScreen(
                                      context, screen: PlayMovieView(
                                      name: mainScreenMovies[0]['title'],
                                      bannerUrl: 'https://image.tmdb.org/t/p/w500'
                                          + mainScreenMovies[0]['backdrop_path'],
                                      posterUrl: 'https://image.tmdb.org/t/p/w500'
                                          +
                                          mainScreenMovies[0]['poster_path'],
                                      description: mainScreenMovies[0]['overview'],
                                      vote: mainScreenMovies[0]['vote_average']
                                          .toString(),
                                      launchOn: mainScreenMovies[0]['release_date'],
                                      language: mainScreenMovies[0]['original_language'],
                                      popularity: mainScreenMovies[0]['popularity'].toString(),
                                      movieId: mainScreenMovies[0]['id'].toString()),
                                      withNavBar: false),
                                },
                                child: Column(children: [
                                  const Icon(Icons.info_outline, size: 30, color: Colors.white,),
                                  Text('Info', style: titleTextStyle,)
                                ],),
                              ),
                            ],
                          ),
                        ),
                      ],
                            /// Favorite Movies View
                            if(myOwnList.isEmpty) ... [],
                            if(myOwnList.isNotEmpty) ... [
                              Padding(
                                  padding: const EdgeInsets.only(top: 30, left: 6,
                                      right: 5, bottom: 3),
                                  child: Text("My List", style: listTextStyle)),
                              FavoriteMovieList(favoriteList: myOwnList),
                            ],
                            /// Popular Movies View
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 6,
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
                              child: Text("Similar to what you've watched", style: listTextStyle)),
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
                            TvAiringTodayList(tvAiring: con.tvAiringToday,),
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
