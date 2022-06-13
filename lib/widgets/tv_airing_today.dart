import 'package:flutter/material.dart';
import 'package:movie_app/views/play_movie_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class TvAiringTodayList extends StatefulWidget {
  final List latest;

  const TvAiringTodayList({Key? key, required this.latest}) : super(key: key);

  @override
  State<TvAiringTodayList> createState() => _TvAiringTodayListState();
}

class _TvAiringTodayListState extends State<TvAiringTodayList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const ScrollPhysics(),
          itemCount: widget.latest.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                pushNewScreen(context, screen: PlayMovieView(
                  name: widget.latest[index]['title'],
                  bannerUrl: 'https://image.tmdb.org/t/p/w500'
                      + widget.latest[index]['backdrop_path'],
                  posterUrl: 'https://image.tmdb.org/t/p/w500'
                      + widget.latest[index]['poster_path'],
                  description: widget.latest[index]['overview'],
                  vote: widget.latest[index]['vote_average'].toString(),
                  launchOn: widget.latest[index]['release_date'],
                  language: widget.latest[index]['original_language'],
                  popularity: widget.latest[index]['popularity'].toString(),
                  sessionId: widget.latest[index]['id'].toString(),),
                    withNavBar: false);
              },
              child: Container(
                  width: 116, height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(image: NetworkImage('https://image.tmdb.org/t/p/w500'
                          + widget.latest[index]['poster_path']))),
                  margin: const EdgeInsets.only(left: 7)),
            );
          }),
    );
  }
}
