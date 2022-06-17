import 'package:flutter/material.dart';
import 'package:movie_app/views/play_movie_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class FavoriteMovieList extends StatefulWidget {
  final List favoriteList;
  const FavoriteMovieList({Key? key, required this.favoriteList}) : super(key: key);

  @override
  State<FavoriteMovieList> createState() => _FavoriteMovieListState();
}

class _FavoriteMovieListState extends State<FavoriteMovieList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const ScrollPhysics(),
          itemCount: widget.favoriteList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                pushNewScreen(context, screen: PlayMovieView(
                  name: widget.favoriteList[index]['title'],
                  bannerUrl: 'https://image.tmdb.org/t/p/w500'
                      + widget.favoriteList[index]['backdrop_path'],
                  posterUrl: 'https://image.tmdb.org/t/p/w500'
                      + widget.favoriteList[index]['poster_path'],
                  description: widget.favoriteList[index]['overview'],
                  vote: widget.favoriteList[index]['vote_average'].toString(),
                  launchOn: widget.favoriteList[index]['release_date'],
                  language: widget.favoriteList[index]['original_language'],
                  popularity: widget.favoriteList[index]['popularity'].toString(),
                sessionId: widget.favoriteList[index]['id'].toString(),),
                    withNavBar: false);
              },
              child: Container(
                  width: 117, height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(image: NetworkImage('https://image.tmdb.org/t/p/w500'
                          + widget.favoriteList[index]['poster_path']))),
                  margin: const EdgeInsets.only(left: 7)),
            );
          }),
    );
  }
}
