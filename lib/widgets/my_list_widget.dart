import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movie_app/controllers/api_controller.dart';
import 'package:movie_app/views/play_movie_view.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:http/http.dart' as http;

class MyListWidget extends StatefulWidget {
  final String movieId;
  const MyListWidget({Key? key, required this.movieId}) : super(key: key);

  @override
  _MyListWidgetState createState() => _MyListWidgetState();
}

class _MyListWidgetState extends StateMVC<MyListWidget> {
  _MyListWidgetState() : super(ApiServiceController()) {
    con = controller as ApiServiceController;
  }

  late ApiServiceController con;

  @override
  void initState() { 
    con.getMovieDetails(movieId: int.parse(widget.movieId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    con.getMovieDetails(movieId: int.parse(widget.movieId));
    return con.movieDetails.isNotEmpty ?
      InkWell(
        onTap: () => {
        pushNewScreen(context, screen: PlayMovieView(
        name: con.movieDetails['title'],
        bannerUrl: 'https://image.tmdb.org/t/p/w500'
        + con.movieDetails['backdrop_path'].toString(),
        posterUrl: 'https://image.tmdb.org/t/p/w500'
        + con.movieDetails['poster_path'].toString(),
        description: con.movieDetails['overview'],
        vote: con.movieDetails['vote_average'].toString(),
        launchOn: con.movieDetails['release_date'],
        language: con.movieDetails['original_language'],
        popularity: con.movieDetails['popularity'].toString(),
        movieId: con.movieDetails['id'].toString(),),
        withNavBar: false)
        },
        child: Container(  
          width: 116, height: 200,
            decoration: BoxDecoration( 
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(image: NetworkImage('https://image.tmdb.org/t/p/w500'
                    + con.movieDetails['poster_path'].toString()))),
          margin: const EdgeInsets.only(left: 7)
    ),
      )
    : Container();
  }
}
