import 'package:flutter/material.dart';
import 'package:movie_app/views/play_movie_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class TvAiringTodayList extends StatefulWidget {
  final List tvAiring;

  const TvAiringTodayList({Key? key, required this.tvAiring}) : super(key: key);

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
          itemCount: widget.tvAiring.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                pushNewScreen(context, screen: PlayMovieView(
                  name: widget.tvAiring[index]['original_name'],
                  bannerUrl: 'https://image.tmdb.org/t/p/w500'
                      + widget.tvAiring[index]['backdrop_path'],
                  posterUrl: 'https://image.tmdb.org/t/p/w500'
                      + widget.tvAiring[index]['poster_path'],
                  description: widget.tvAiring[index]['overview'],
                  vote: widget.tvAiring[index]['vote_average'].toString(),
                  launchOn: widget.tvAiring[index]['first_air_date'],
                  language: widget.tvAiring[index]['original_language'],
                  popularity: widget.tvAiring[index]['popularity'].toString(),
                  movieId: widget.tvAiring[index]['id'].toString(),),
                    withNavBar: false);
              },
              child: Container(
                  width: 116, height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(image: NetworkImage('https://image.tmdb.org/t/p/w500'
                          + widget.tvAiring[index]['poster_path']))),
                  margin: const EdgeInsets.only(left: 7)),
            );
          }),
    );
  }
}
