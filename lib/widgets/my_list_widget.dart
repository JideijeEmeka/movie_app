import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movie_app/views/play_movie_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:http/http.dart' as http;

class MyListWidget extends StatefulWidget {
  final String movieId;
  const MyListWidget({Key? key, required this.movieId}) : super(key: key);

  @override
  State<MyListWidget> createState() => _MyListWidgetState();
}

class _MyListWidgetState extends State<MyListWidget> {

  Map<String, dynamic> movie = {};

  fetchDetails() async {
    String url = 'https://api.themoviedb.org/3/movie/${widget.movieId}?api_key=2a209b9033ad19c74ec7ab61c4cd582e';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      debugPrint(response.body);
      setState((){
        movie = jsonDecode(response.body);
      });
    }else{
      debugPrint('error');
    }
  } 

  @override
  void initState() { 
    fetchDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fetchDetails();
    return movie.isNotEmpty ?
      InkWell(
        onTap: () => {
        pushNewScreen(context, screen: PlayMovieView(
        name: movie['title'],
        bannerUrl: 'https://image.tmdb.org/t/p/w500'
        + movie['backdrop_path'].toString(),
        posterUrl: 'https://image.tmdb.org/t/p/w500'
        + movie['poster_path'].toString(),
        description: movie['overview'],
        vote: movie['vote_average'].toString(),
        launchOn: movie['release_date'],
        language: movie['original_language'],
        popularity: movie['popularity'].toString(),
        movieId: movie['id'].toString(),),
        withNavBar: false)
        },
        child: Container(  
          width: 116, height: 200,
            decoration: BoxDecoration( 
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(image: NetworkImage('https://image.tmdb.org/t/p/w500'
                    + movie['poster_path'].toString()))),
          margin: const EdgeInsets.only(left: 7)
    ),
      )
    : Container();
  }
}
