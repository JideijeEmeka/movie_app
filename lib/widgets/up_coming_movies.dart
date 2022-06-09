import 'package:flutter/material.dart';
import 'package:movie_app/views/play_movie_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class UpComingMovies extends StatefulWidget {
  final List upComing;

  const UpComingMovies({Key? key, required this.upComing}) : super(key: key);

  @override
  State<UpComingMovies> createState() => _UpComingMoviesState();
}

class _UpComingMoviesState extends State<UpComingMovies> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const ScrollPhysics(),
          itemCount: widget.upComing.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                pushNewScreen(context, screen: PlayMovieView(
                  name: widget.upComing[index]['title'],
                  bannerUrl: 'https://image.tmdb.org/t/p/w500'
                      + widget.upComing[index]['backdrop_path'],
                  posterUrl: 'https://image.tmdb.org/t/p/w500'
                      + widget.upComing[index]['poster_path'],
                  description: widget.upComing[index]['overview'],
                  vote: widget.upComing[index]['vote_average'].toString(),
                  launchOn: widget.upComing[index]['release_date'],
                  language: widget.upComing[index]['original_language'],
                  popularity: widget.upComing[index]['popularity'].toString(),
                sessionId: widget.upComing[index]['id'].toString(),),
                    withNavBar: false);
              },
              child: Container(
                  width: 116, height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      image: DecorationImage(image: NetworkImage('https://image.tmdb.org/t/p/w500'
                          + widget.upComing[index]['poster_path']))),
                  margin: const EdgeInsets.only(left: 7)),
            );
          }),
    );
  }
}
