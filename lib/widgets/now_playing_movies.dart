import 'package:flutter/material.dart';
import 'package:movie_app/views/play_movie_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class NowPlayingMoviesList extends StatefulWidget {
  final List nowPlaying;

  const NowPlayingMoviesList({Key? key, required this.nowPlaying}) : super(key: key);

  @override
  State<NowPlayingMoviesList> createState() => _NowPlayingMoviesListState();
}

class _NowPlayingMoviesListState extends State<NowPlayingMoviesList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const ScrollPhysics(),
          itemCount: widget.nowPlaying.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                pushNewScreen(context, screen: PlayMovieView(
                  name: widget.nowPlaying[index]['title'],
                  bannerUrl: 'https://image.tmdb.org/t/p/w500'
                      + widget.nowPlaying[index]['backdrop_path'],
                  posterUrl: 'https://image.tmdb.org/t/p/w500'
                      + widget.nowPlaying[index]['poster_path'],
                  description: widget.nowPlaying[index]['overview'],
                  vote: widget.nowPlaying[index]['vote_average'].toString(),
                  launchOn: widget.nowPlaying[index]['release_date'],
                  language: widget.nowPlaying[index]['original_language'],
                  popularity: widget.nowPlaying[index]['popularity'].toString(),
                  sessionId: widget.nowPlaying[index]['id'].toString(),),
                    withNavBar: false);
              },
              child: Container(
                  width: 116, height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      image: DecorationImage(image: NetworkImage('https://image.tmdb.org/t/p/w500'
                          + widget.nowPlaying[index]['poster_path']))),
                  margin: const EdgeInsets.only(left: 7)),
            );
          }),
    );
  }
}
