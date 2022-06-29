import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/controllers/api_controller.dart';
import 'package:movie_app/helpers/constants.dart';
import 'package:movie_app/helpers/utility.dart';
import 'package:movie_app/views/play_movie_view.dart';
import 'package:movie_app/widgets/buttons/floating_action_button.dart';
import 'package:movie_app/widgets/snack_bar_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends StateMVC<SearchView> {
  _SearchViewState() : super(ApiServiceController()) {
    con = controller as ApiServiceController;
  }

  late ApiServiceController con;

  bool isLoading = false;
  final Utility _utility = Utility();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  restoreHiddenMovies() async {
    con.clearHiddenList();
    ///showBack.addAll(con.hiddenMovieList);
    con.hiddenMovieList = [];
    con.searchedMovies = await con.searchMovies(searchController.text);
    setState(() { });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: floatButton(() {
        restoreHiddenMovies();
      },
          "Show hidden movies",
        const Icon(CupertinoIcons.eye_fill)),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: BackButton(onPressed: () => Navigator.pop(context),
            color: Colors.white,),
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              width: 30,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white
              ),
            )
          ],
        ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            color: Colors.brown.withOpacity(0.4),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                const Icon(Icons.search, color: Colors.white, size: 28),
                const SizedBox(width: 15,),
                Expanded(
                  child: TextField(
                    controller: searchController,
                    style: titleTextStyle,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Search for a show, movie, genre, etc',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.6),
                          fontSize: 17),
                  ),),
                ),
                IconButton(onPressed: () async {
                  if(searchController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar
                      (message: 'Pls input a movie name'));
                  }else {
                    setState(() {
                      isLoading = true;
                    });
                    FocusManager.instance.primaryFocus?.unfocus();
                    await Future.delayed(const Duration(seconds: 4), () async{
                    con.similarMovies = await  con.searchMovies(searchController.text);
                    con.getMyHideList();
                      setState(() { });
                    });
                    setState(() {
                      isLoading = false;
                    });
                  }
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                  icon: const Icon(Icons.send, color: Colors.white,))
              ],),
            ),
          ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Text("Top Searches", style: listTextStyle,),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: !isLoading ?
              SizedBox(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: con.searchedMovies.length,
                      itemBuilder: (c,i){
                        return
                          con.hiddenMovieList.contains(con.searchedMovies[i]["id"].toString())?
                              Container()
                        :InkWell(
                          onTap: (){
                            pushNewScreen(context, screen: PlayMovieView(
                              name: con.searchedMovies[i]['title'],
                              bannerUrl: 'https://image.tmdb.org/t/p/w500'
                                  + con.searchedMovies[i]['backdrop_path'].toString(),
                              posterUrl: 'https://image.tmdb.org/t/p/w500'
                                  + con.searchedMovies[i]['poster_path'].toString(),
                              description: con.searchedMovies[i]['overview'],
                              vote: con.searchedMovies[i]['vote_average'].toString(),
                              launchOn: con.searchedMovies[i]['release_date'],
                              language: con.searchedMovies[i]['original_language'],
                              popularity: con.searchedMovies[i]['popularity'].toString(),
                              movieId: '${con.searchedMovies[i]['id']}',),
                                withNavBar: false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: MediaQuery(data: const MediaQueryData(padding: EdgeInsets.zero),
                              child: ListTile(
                                leading: Image.network('https://image.tmdb.org/t/p/w500'
                                    + con.searchedMovies[i]['poster_path'].toString(), fit: BoxFit.cover,),
                                title: Text('${con.searchedMovies[i]['title']}',
                                  style: titleTextStyle,),
                                /// Hide movie from future search
                                trailing: IconButton(onPressed: () {
                                  print(con.searchedMovies[i]["id"]);
                                  con.saveHideToList(con.searchedMovies[i]["id"].toString()).then((_) =>
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        snackBar(message: 'Hidden from Search!'))
                                  });
                                  con.searchedMovies.removeAt(i);
                                  setState(() { });
                                  print(con.hiddenMovieList);
                                },
                                    icon: const Icon(Icons.remove, color: Colors.white)),
                                tileColor: Colors.brown.withOpacity(0.4),
                                contentPadding: const EdgeInsets.only(left: 0.0,
                                    right: 20.0, top: 0.0, bottom: 0.0),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 30,)
                  ],
                ),
              ):
            Center(child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: _utility.loader(context, 'Searching...'),
            )),),
        ],),
      ),
    );
  }
}
