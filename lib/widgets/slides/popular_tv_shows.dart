import 'package:flutter/material.dart';
import 'package:movie_app/controllers/api_controller.dart';
import 'package:movie_app/views/play_movie_view.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class PopularTvShows extends StatefulWidget {
  final List popularTvShows;


  const PopularTvShows({Key? key, required this.popularTvShows}) : super(key: key);

  @override
  _PopularTvShowsState createState() => _PopularTvShowsState();
}

class _PopularTvShowsState extends StateMVC<PopularTvShows> {
  _PopularTvShowsState() : super(ApiServiceController()) {
    con = controller as ApiServiceController;
  }

  late ApiServiceController con;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const ScrollPhysics(),
          itemCount: widget.popularTvShows.length,
          itemBuilder: (context, index) {
            // index == con.index;
            return InkWell(
              onTap: () {
                pushNewScreen(context, screen: PlayMovieView(
                  name: widget.popularTvShows[index]['original_name'],
                  bannerUrl: 'https://image.tmdb.org/t/p/w500'
                      + widget.popularTvShows[index]['backdrop_path'],
                  posterUrl: 'https://image.tmdb.org/t/p/w500'
                      + widget.popularTvShows[index]['poster_path'],
                  description: widget.popularTvShows[index]['overview'],
                  vote: widget.popularTvShows[index]['vote_average'].toString(),
                  launchOn: widget.popularTvShows[index]['first_air_date'],
                  language: widget.popularTvShows[index]['original_language'],
                  popularity: widget.popularTvShows[index]['popularity'].toString(),
                  sessionId: widget.popularTvShows[index]['id'].toString(),),
                    withNavBar: false);
              },
              child: Container(
                  width: 116, height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(image: NetworkImage('https://image.tmdb.org/t/p/w500'
                          + widget.popularTvShows[index]['poster_path']))),
                  margin: const EdgeInsets.only(left: 7)),
            );
          }),
    );
  }
}
