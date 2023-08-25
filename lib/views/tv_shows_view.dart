import 'package:flutter/material.dart';
import 'package:movie_app/controllers/api_controller.dart';
import 'package:movie_app/helpers/constants.dart';
import 'package:movie_app/helpers/utility.dart';
import 'package:movie_app/views/play_movie_view.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class TvShowsView extends StatefulWidget {
  final List tvShows;
  const TvShowsView({Key? key, required this.tvShows}) : super(key: key);

  @override
  _TvShowsViewState createState() => _TvShowsViewState();
}

class _TvShowsViewState extends StateMVC<TvShowsView> {
  _TvShowsViewState() : super(ApiServiceController()) {
    con = controller as ApiServiceController;
  }

  late ApiServiceController con;
  final utility = Utility();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      con.getTvShows();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Tv Show'),
          titleTextStyle: loadingTextStyle,
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: BackButton(onPressed: () => Navigator.pop(context), color: Colors.black)),
      body: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: widget.tvShows.length,
          itemBuilder: (context, index) {
            return con.isLoading ? utility.circularLoader()
                : InkWell( onTap: () {
              pushNewScreen(context, screen: PlayMovieView(
                  name: con.checkNull(widget.tvShows[index]['title']),
                  bannerUrl: con.checkNull('https://image.tmdb.org/t/p/w500'
                      + widget.tvShows[index]['backdrop_path'].toString()),
                  posterUrl: con.checkNull('https://image.tmdb.org/t/p/w500'
                      + widget.tvShows[index]['poster_path'].toString()),
                  description: con.checkNull(widget.tvShows[index]['overview']),
                  vote: con.checkNull(widget.tvShows[index]['vote_average'].toString()),
                  launchOn: con.checkNull(widget.tvShows[index]['release_date']),
                  language: con.checkNull(widget.tvShows[index]['original_language']),
                  popularity: con.checkNull(widget.tvShows[index]['popularity'].toString()),
                  movieId: con.checkNull(widget.tvShows[index]['id'].toString())),
                  withNavBar: false);
            },
              child: Container(
                  width: 116, height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(image: NetworkImage('https://image.tmdb.org/t/p/w500'
                          + widget.tvShows[index]['poster_path']))),
                  margin: const EdgeInsets.only(left: 7)),
            );
          }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 5, childAspectRatio: 6/9)),
    );
  }
}
