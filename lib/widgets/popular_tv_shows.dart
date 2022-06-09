import 'package:flutter/material.dart';
import 'package:movie_app/views/play_movie_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class PopularTvShows extends StatefulWidget {
  final List popularTvShows;

  const PopularTvShows({Key? key, required this.popularTvShows}) : super(key: key);

  @override
  State<PopularTvShows> createState() => _PopularTvShowsState();
}

class _PopularTvShowsState extends State<PopularTvShows> {
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
            return InkWell(
              onTap: () {
                // pushNewScreen(context, screen: const PlayMovieView(),
                //     withNavBar: false);
              },
              child: Container(
                  width: 116, height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      image: DecorationImage(image: NetworkImage('https://image.tmdb.org/t/p/w500'
                          + widget.popularTvShows[index]['poster_path']))),
                  margin: const EdgeInsets.only(left: 7)),
            );
          }),
    );
  }
}
