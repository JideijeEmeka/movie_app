import 'package:flutter/material.dart';
import 'package:movie_app/controllers/api_controller.dart';
import 'package:movie_app/views/play_movie_view.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class TrendingMovieList extends StatefulWidget {
  final List trending;

  const TrendingMovieList({Key? key, required this.trending}) : super(key: key);

  @override
  _TrendingMovieListState createState() => _TrendingMovieListState();
}

class _TrendingMovieListState extends StateMVC<TrendingMovieList> {
  _TrendingMovieListState() : super(ApiServiceController()) {
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
          itemCount: widget.trending.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                pushNewScreen(context, screen: PlayMovieView(
                  name: con.checkNull(widget.trending[index]['title']),
                bannerUrl: con.checkNull('https://image.tmdb.org/t/p/w500'
                    + widget.trending[index]['backdrop_path'].toString()),
                posterUrl: con.checkNull('https://image.tmdb.org/t/p/w500'
                    + widget.trending[index]['poster_path'].toString()),
                description: con.checkNull(widget.trending[index]['overview']),
                vote: con.checkNull(widget.trending[index]['vote_average'].toString()),
                launchOn: con.checkNull(widget.trending[index]['release_date']),
                language: con.checkNull(widget.trending[index]['original_language']),
                popularity: con.checkNull(widget.trending[index]['popularity'].toString()),
                movieId: con.checkNull(widget.trending[index]['id'].toString()),),
                    withNavBar: false);
                },
              child: Container(
                  width: 116, height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(image: NetworkImage('https://image.tmdb.org/t/p/w500'
                        + widget.trending[index]['poster_path']))),
                  margin: const EdgeInsets.only(left: 7)),
            );
          }),
    );
  }
}
