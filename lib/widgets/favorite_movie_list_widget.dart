import 'package:flutter/material.dart';
import 'package:movie_app/views/play_movie_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class FavoriteMovieList extends StatefulWidget {
  const FavoriteMovieList({Key? key}) : super(key: key);

  @override
  State<FavoriteMovieList> createState() => _FavoriteMovieListState();
}

class _FavoriteMovieListState extends State<FavoriteMovieList> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushNewScreen(context, screen: const PlayMovieView(),
            withNavBar: false);
      },
      child: Container(
          width: 150,
          height: 200,
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white), child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset
          ("assets/images/movie_img.png", width: 200, height: 150, fit: BoxFit.fill),
      )),
    );
  }
}
