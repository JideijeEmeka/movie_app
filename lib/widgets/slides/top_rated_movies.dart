import 'package:flutter/material.dart';
import 'package:movie_app/views/play_movie_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class TopRatedMovies extends StatefulWidget {
  final List topRated;

  const TopRatedMovies({Key? key, required this.topRated}) : super(key: key);

  @override
  State<TopRatedMovies> createState() => _TopRatedMoviesState();
}

class _TopRatedMoviesState extends State<TopRatedMovies> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const ScrollPhysics(),
          itemCount: widget.topRated.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                pushNewScreen(context, screen: PlayMovieView(
                  name: widget.topRated[index]['title'],
                  bannerUrl: 'https://image.tmdb.org/t/p/w500'
                      + widget.topRated[index]['backdrop_path'],
                  posterUrl: 'https://image.tmdb.org/t/p/w500'
                      + widget.topRated[index]['poster_path'],
                  description: widget.topRated[index]['overview'],
                  vote: widget.topRated[index]['vote_average'].toString(),
                  launchOn: widget.topRated[index]['release_date'],
                  language: widget.topRated[index]['original_language'],
                  popularity: widget.topRated[index]['popularity'].toString(),
                  sessionId: widget.topRated[index]['id'].toString(),),
                    withNavBar: false);
              },
              child: Container(
                  width: 116, height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(image: NetworkImage('https://image.tmdb.org/t/p/w500'
                          + widget.topRated[index]['poster_path']))),
                  margin: const EdgeInsets.only(left: 7)),
            );
          }),
    );
  }
}
