import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_app/helpers/constants.dart';
import 'package:movie_app/widgets/snack_bar_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb_api/tmdb_api.dart';

class ApiServiceController extends ControllerMVC {

  bool hasInternet = false;
  bool tapped = false;
  int tappedOnce = 1;
  ConnectivityResult result = ConnectivityResult.none;
  int? list;
  List myList = [];

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences prefs;

  Future getSharedPrefs() async {
    prefs = await _prefs;
    list = (prefs.containsKey('savedList') ? prefs.getInt('savedList') : 0)!;
    setState(() {
      myList = list as List;
    });
  }
  
  Future addMovie(BuildContext context) async {
    if(tappedOnce == 2 && tapped == true) {
      /// Populate my local List with fetched list on first click

      ScaffoldMessenger.of(context).showSnackBar(snackBar(message: "Added to Favorite!"));
    }else if(tappedOnce == 3){
      /// Remove movie from my local List on second click
      ScaffoldMessenger.of(context).showSnackBar(snackBar(message: "Removed from Favorite!"));
    }
    prefs.setInt('savedList', int.parse(myList.toString()));
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

  /// Load movies
  List trendingMovies = [];
  List topRatedMovies = [];
  List nowPlaying = [];
  List popularMovies = [];
  List upComingTvShows = [];
  List recommendedMovies = [];
  List similarMovies = [];
  List tvAiringToday = [];
  List popularTvShows = [];
  List myFavList = [];
  // List myFavoriteMoviesList = [];
  // List myFavoriteMovies = [];
  // List myList = [];

  createList() async {
    Map myFavMoviesList = await tmdbWithCustomLogs.v3.lists.createList('20', 'lol', 'okay');
    setState(() {
      myFavList = myFavMoviesList[0]['list_id'];
    });
  }

  addMovieItem() async {
    Map added = await tmdbWithCustomLogs.v3.lists.addItem('20', 'list_id', 2);
    setState(() {
      myFavList.insert(0, popularMovies);
    });
  }

  TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true
      ));

  loadMovies() async {
    Map trendingResults = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topRatedResults = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map popularMoviesResults = await tmdbWithCustomLogs.v3.movies.getPopular();
    Map upComingTvResults = await tmdbWithCustomLogs.v3.movies.getUpcoming();
    Map nowPlayingResults = await tmdbWithCustomLogs.v3.movies.getNowPlaying();
    Map recommendedMoviesResults = await tmdbWithCustomLogs.v3.movies
        .getRecommended(2, language: 'en-US');
    Map similarMoviesResults = await tmdbWithCustomLogs.v3.movies
        .getSimilar(2, language: 'en-US');
    Map tvAiringTodayResults = await tmdbWithCustomLogs.v3.tv
        .getAiringToday(language: 'en-US', page: 2);
    Map popularTvShowsResults = await tmdbWithCustomLogs.v3.tv
        .getPopular(language: 'en-US', page: 2);
    setState(() {
      trendingMovies = trendingResults['results'];
      topRatedMovies = topRatedResults['results'];
      popularMovies = popularMoviesResults['results'];
      upComingTvShows = upComingTvResults['results'];
      nowPlaying = nowPlayingResults['results'];
      recommendedMovies = recommendedMoviesResults['results'];
      similarMovies = similarMoviesResults['results'];
      tvAiringToday = tvAiringTodayResults['results'];
      popularTvShows = popularTvShowsResults['results'];
    });
  }


  // addPopularMoviesToList() async {
  //   // print('$popularMovies');
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setStringList('savedList', myList as List<String>);
  //     setState(() {
  //       if(myList.isEmpty) {
  //         prefs.getStringList('savedList');
  //       }
  //       myList = popularMovies as List<String>;
  //     });
  //     print('$myList');
  // }
  //
  // addMovieToList(BuildContext context) async {
  //   print('$myFavoriteMovies');
  //   final prefs = await SharedPreferences.getInstance();
  //   var listId = prefs.getInt('listId');
  //
  //     Map myFavMoviesList = await tmdbWithCustomLogs.v3.lists.createList('20', 'lol', 'okay');
  //     Map myList = await tmdbWithCustomLogs.v3.lists.addItem('20', 'listId', 2);
  //
  //     listId = myFavMoviesList["list_id"];
  //
  //     // store listId in e.g sharedPrefs
  //     await prefs.setInt('listId', listId!);
  //
  //   // Map myFavMoviesResults = await tmdbWithCustomLogs.v3.lists.addItem('emmy', listId.toString(), 2);
  //   setState(() {
  //     myFavoriteMovies = myList['results'];
  //   });
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
  //   Text('You added a movie', style: titleTextStyle,), elevation: 5,
  //     backgroundColor: Colors.brown.withOpacity(0.4),
  //     margin: const EdgeInsets.only(bottom: 100), behavior: SnackBarBehavior.floating,));
  // }

  ApiServiceController();

}

