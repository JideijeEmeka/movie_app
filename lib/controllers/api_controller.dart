import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_app/helpers/constants.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb_api/tmdb_api.dart';

class ApiServiceController extends ControllerMVC {

  bool hasInternet = false;
  ConnectivityResult result = ConnectivityResult.none;
  List hiddenMovieList = [];

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences prefs;

  Future<List<String>> getMyList() async {
    prefs = await _prefs;
    // prefs.clear();

    if(prefs.getStringList('savedList') == null) {
      prefs.setStringList('savedList', []);
    }
    List<String> list = prefs.getStringList('savedList')!;
    setState(() {
      myOwnList = list;
    });
    return list;
  }

  Future<List<String>> getMyHideList() async {
    prefs = await _prefs;
    // prefs.clear();

    if(prefs.getStringList('hiddenList') == null) {
      prefs.setStringList('hiddenList', []);
    }
    List<String> list = prefs.getStringList('hiddenList')!;
    setState(() {
      myHiddenMovieList = list;
      hiddenMovieList = list;
    });
    return list;
  }

  Future clearHiddenList() async {
    prefs.setStringList('hiddenList', []);
  }

  Future<String> saveHideToList(String id) async {
    String result = "";
    try{
      List<String> list = await getMyHideList();
      list.add(id);
      prefs.setStringList('hiddenList', list);
      setState(() {
        myHiddenMovieList.add(id);
      });
      result = 'Hidden from Search!';
    }catch(error) {
      result = error.toString();
    }
    return result;
  }

  Future<String> addMovieToList(String id) async {
    String result = "";
    try{
      List<String> list = await getMyList();
      list.insert(0, id);
      prefs.setStringList('savedList', list);
      setState(() {
        myOwnList.insert(0, id);
      });
      result = 'Added to favorite!';
    }catch(error) {
      result = error.toString();
    }
    return result;
  }

  Future<String> removeMovieFromList(String id) async {
    String result = "";
    try{
      List<String> list = await getMyList();
      list.remove(id);
      prefs.setStringList('savedList', list);
      setState(() {
        myOwnList.remove(id);
      });
      result = 'Removed from favorite!';
    }catch(error) {
      result = error.toString();
    }
    return result;
  }

  Future<String> hideMovieFromSearchResults(String id) async {
    String result = "";
    try{
      List<String> list = await getMyList();
      list.remove(id);
      prefs.setStringList('savedList', list);
      setState(() {
        myHiddenMovieList.add(id);
      });
      result = 'Removed from Search!';
    }catch(error) {
      result = error.toString();
    }
    return result;
  }

  /// Search Movies
  List searchedMovies = [];

  Future <List> searchMovies(String query) async {
    Map searchResults = await tmdbWithCustomLogs.v3.search.queryMovies(query);
    setState(() {
      searchedMovies = searchResults['results'];
    });

    return searchResults['results'];


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

  ApiServiceController();

}

