import 'package:flutter/material.dart';
import 'package:movie_app/helpers/constants.dart';
import 'package:movie_app/helpers/utility.dart';
import 'package:movie_app/widgets/searched_movies.dart';
import 'package:tmdb_api/tmdb_api.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  bool isLoading = false;
  final Utility _utility = Utility();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    searchMovies(searchController.text);
    super.initState();
  }

  /// Search Movies
  List searchedMovies = [];

  TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true
      ));

  searchMovies(String query) async {
    Map searchResults = await tmdbWithCustomLogs.v3.search.queryMovies(query);
    setState(() {
      searchedMovies = searchResults['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 17),
                  ),),
                ),
                IconButton(onPressed: () async {
                  if(searchController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                    Text('Pls input a movie name', style: loadingTextStyle,), elevation: 5,
                      backgroundColor: Colors.brown.withOpacity(0.4),
                    margin: const EdgeInsets.only(bottom: 100), behavior: SnackBarBehavior.floating,));
                  }else {
                    setState(() {
                      isLoading = true;
                    });
                    await Future.delayed(const Duration(seconds: 3), () {
                      searchMovies(searchController.text);
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
              margin: const EdgeInsets.only(bottom: 80),
              child: !isLoading ?
            SearchedMovieList(searching: searchedMovies) :
            Center(child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: _utility.loader(context, 'Searching...'),
            )),),
        ],),
      ),
    );
  }
}
