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
      debugPrint('$newList');
  }

  @override
  Widget build(BuildContext context) {
   fetchList();
    return SizedBox(
      height: 170,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const ScrollPhysics(),
          itemCount: myOwnList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                print(myOwnList);
                pushNewScreen(context, screen: PlayMovieView(
                  name: myOwnList[index],
                  bannerUrl: myOwnList[index],
                  posterUrl: myOwnList[index],
                  description: myOwnList[index],
                  vote: myOwnList[index],
                  launchOn: myOwnList[index],
                  language: myOwnList[index],
                  popularity: myOwnList[index],
                movieId: myOwnList[index]),
                    withNavBar: false);
              },
              child: Container(
                  width: 117, height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(image: NetworkImage(myOwnList[index]))),
                  margin: const EdgeInsets.only(left: 7)),
            );
          }),
    );
  }
}
