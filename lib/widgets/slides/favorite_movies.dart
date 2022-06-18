import 'package:flutter/material.dart';
import 'package:movie_app/controllers/api_controller.dart';
import 'package:movie_app/helpers/constants.dart';
import 'package:movie_app/views/play_movie_view.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class FavoriteMovieList extends StatefulWidget {
  final List favoriteList;
  const FavoriteMovieList({Key? key, required this.favoriteList}) : super(key: key);

  @override
  _FavoriteMovieListState createState() => _FavoriteMovieListState();
}

class _FavoriteMovieListState extends StateMVC<FavoriteMovieList> {
  _FavoriteMovieListState() : super(ApiServiceController()) {
    con = controller as ApiServiceController;
  }

  late ApiServiceController con;
  List<String> newList = [];

  @override
  void initState() {
    fetchList();
    super.initState();
  }

  fetchList() async {
      var i = await con.getMyList();
      setState(() {
        newList = i;
      });
      print(newList);
  }

  // Widget getMovie(String id){
  // con.tmdbWithCustomLogs.v3.movies.getDetails(int.parse(id));
  // }
  @override
  Widget build(BuildContext context) {
   // fetchList();
    return SizedBox(
      height: 170,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const ScrollPhysics(),
          itemCount: myOwnList.length,
          itemBuilder: (context, index) {
            return Image.network(myOwnList[index], height: 100, width: 100,fit: BoxFit.fill);

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
                movieId: widget.favoriteList[index]['id'].toString(),),
                    withNavBar: false);
              },
              child: Container(
                  width: 117, height: 200,
                  child: Center(child: Text("book", style: titleTextStyle,)),
                  // decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(8),
                  //     image: DecorationImage(image: NetworkImage('https://image.tmdb.org/t/p/w500'
                  //         + widget.favoriteList[index]['poster_path'].toString()))),
                  margin: const EdgeInsets.only(left: 7)),
            );
          }),
    );
  }
}
