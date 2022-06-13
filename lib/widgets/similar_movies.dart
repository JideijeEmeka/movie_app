import 'package:flutter/material.dart';
import 'package:movie_app/views/play_movie_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SimilarMoviesList extends StatefulWidget {
  final List similarMovies;

  const SimilarMoviesList({Key? key, required this.similarMovies}) : super(key: key);

  @override
  State<SimilarMoviesList> createState() => _SimilarMoviesListState();
}

class _SimilarMoviesListState extends State<SimilarMoviesList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const ScrollPhysics(),
          itemCount: widget.similarMovies.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                pushNewScreen(context, screen: PlayMovieView(
                  name: widget.similarMovies[index]['title'],
                  bannerUrl: 'https://image.tmdb.org/t/p/w500'
                      + widget.similarMovies[index]['backdrop_path'],
                  posterUrl: 'https://image.tmdb.org/t/p/w500'
                      + widget.similarMovies[index]['poster_path'],
                  description: widget.similarMovies[index]['overview'],
                  vote: widget.similarMovies[index]['vote_average'].toString(),
                  launchOn: widget.similarMovies[index]['release_date'],
                  language: widget.similarMovies[index]['original_language'],
                  popularity: widget.similarMovies[index]['popularity'].toString(),
                  sessionId: widget.similarMovies[index]['id'].toString(),),
                    withNavBar: false);
              },
              child: Container(
                  width: 116, height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      image: DecorationImage(image: NetworkImage('https://image.tmdb.org/t/p/w500'
                          + widget.similarMovies[index]['poster_path']))),
                  margin: const EdgeInsets.only(left: 7)),
            );
          }),
    );
  }
}
