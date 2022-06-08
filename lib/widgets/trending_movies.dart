import 'package:flutter/material.dart';
import 'package:movie_app/views/play_movie_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class TrendingMovieList extends StatefulWidget {
  final List trending;

  const TrendingMovieList({Key? key, required this.trending}) : super(key: key);

  @override
  State<TrendingMovieList> createState() => _TrendingMovieListState();
}

class _TrendingMovieListState extends State<TrendingMovieList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const ScrollPhysics(),
          itemCount: widget.trending.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                pushNewScreen(context, screen: const PlayMovieView(),
                    withNavBar: false);
              },
              child: Container(
                  width: 130,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: NetworkImage('https://image.tmdb.org/t/p/w500'
                        + widget.trending[index]['poster_path']))
                  ),
                  margin: const EdgeInsets.only(left: 7)),
            );
          }),
    );
  }
}
