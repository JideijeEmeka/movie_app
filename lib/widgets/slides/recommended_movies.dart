import 'package:flutter/material.dart';
import 'package:movie_app/views/play_movie_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class RecommendedMoviesList extends StatefulWidget {
  final List recommended;

  const RecommendedMoviesList({Key? key, required this.recommended}) : super(key: key);

  @override
  State<RecommendedMoviesList> createState() => _RecommendedMoviesListState();
}

class _RecommendedMoviesListState extends State<RecommendedMoviesList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const ScrollPhysics(),
          itemCount: widget.recommended.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                pushNewScreen(context, screen: PlayMovieView(
                  name: widget.recommended[index]['title'],
                  bannerUrl: 'https://image.tmdb.org/t/p/w500'
                      + widget.recommended[index]['backdrop_path'],
                  posterUrl: 'https://image.tmdb.org/t/p/w500'
                      + widget.recommended[index]['poster_path'],
                  description: widget.recommended[index]['overview'],
                  vote: widget.recommended[index]['vote_average'].toString(),
                  launchOn: widget.recommended[index]['release_date'],
                  language: widget.recommended[index]['original_language'],
                  popularity: widget.recommended[index]['popularity'].toString(),
                  movieId: widget.recommended[index]['id'].toString(),),
                    withNavBar: false);
              },
              child: Container(
                  width: 116, height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(image: NetworkImage('https://image.tmdb.org/t/p/w500'
                          + widget.recommended[index]['poster_path']))),
                  margin: const EdgeInsets.only(left: 7)),
            );
          }),
    );
  }
}
