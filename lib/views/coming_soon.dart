import 'package:flutter/material.dart';
import 'package:movie_app/controllers/api_controller.dart';
import 'package:movie_app/helpers/constants.dart';
import 'package:movie_app/helpers/utility.dart';
import 'package:movie_app/views/play_movie_view.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ComingSoon extends StatefulWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  _ComingSoonState createState() => _ComingSoonState();
}

class _ComingSoonState extends StateMVC<ComingSoon> {
  _ComingSoonState() : super(ApiServiceController()) {
    con = controller as ApiServiceController;
  }

  late ApiServiceController con;
  final utility = Utility();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      con.loadMovies();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.8),
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Movies Coming Soon'),
          titleTextStyle: appBarTextStyle,
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
        toolbarHeight: 100,
      ),
      body: con.isLoading ? Center(child: utility.circularLoader()) : ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: con.upComingTvShows.length,
            itemBuilder: (c, i) {
              return InkWell(
                  onTap: () {
                    pushNewScreen(context, screen: PlayMovieView(
                      name: con.upComingTvShows[i]['title'],
                      bannerUrl: 'https://image.tmdb.org/t/p/w500'
                          + con.upComingTvShows[i]['backdrop_path'].toString(),
                      posterUrl: 'https://image.tmdb.org/t/p/w500'
                          + con.upComingTvShows[i]['poster_path'].toString(),
                      description: con.upComingTvShows[i]['overview'],
                      vote: con.upComingTvShows[i]['vote_average'].toString(),
                      launchOn: con.upComingTvShows[i]['release_date'],
                      language: con.upComingTvShows[i]['original_language'],
                      popularity: con.upComingTvShows[i]['popularity'].toString(),
                      movieId: '${con.upComingTvShows[i]['id']}',),
                        withNavBar: false);
                  },
                  child: Column(
                    children: [
                      MediaQuery(data: const MediaQueryData(padding: EdgeInsets.zero),
                          child: ListTile(
                            leading: SizedBox(
                              height: 100, width: 100,
                              child: Image.network('https://image.tmdb.org/t/p/w500'
                                  + con.upComingTvShows[i]['poster_path'].toString(), fit: BoxFit.cover),
                            ),
                            title: Text('${con.upComingTvShows[i]['title']}',
                              style: titleTextStyle),
                            contentPadding: const EdgeInsets.only(left: 0.0,
                                right: 20.0, top: 0.0, bottom: 0.0),
                          ),
                        ),
                      Container(
                        height: 3,
                        color: Colors.black,
                      )
                    ],
                  ),
                );
            },
          ),
    );
  }
}
