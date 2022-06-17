import 'package:flutter/material.dart';
import 'package:movie_app/views/play_movie_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class PopularMovies extends StatefulWidget {
  final List popularMovies;

  const PopularMovies({Key? key, required this.popularMovies}) : super(key: key);

  @override
  State<PopularMovies> createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovies> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const ScrollPhysics(),
          itemCount: widget.popularMovies.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                pushNewScreen(context, screen: PlayMovieView(
                  name: widget.popularMovies[index]['title'],
                  bannerUrl: 'https://image.tmdb.org/t/p/w500'
                      + widget.popularMovies[index]['backdrop_path'],
                  posterUrl: 'https://image.tmdb.org/t/p/w500'
                      + widget.popularMovies[index]['poster_path'],
                  description: widget.popularMovies[index]['overview'],
                  vote: widget.popularMovies[index]['vote_average'].toString(),
                  launchOn: widget.popularMovies[index]['release_date'],
                  language: widget.popularMovies[index]['original_language'],
                  popularity: widget.popularMovies[index]['popularity'].toString(),
                  sessionId: widget.popularMovies[index]['id'].toString()),
                    withNavBar: false);
              },
              child: Container(
                  width: 116, height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(image: NetworkImage('https://image.tmdb.org/t/p/w500'
                          + widget.popularMovies[index]['poster_path']))),
                  margin: const EdgeInsets.only(left: 7)),
            );
          }),
    );
  }
}
