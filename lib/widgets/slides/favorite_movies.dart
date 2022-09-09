import 'package:flutter/material.dart';
import 'package:movie_app/controllers/api_controller.dart';
import 'package:movie_app/helpers/constants.dart';
import 'package:movie_app/widgets/my_list_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

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
            return MyListWidget(movieId: myOwnList[index]);
          }),
    );
  }
}
