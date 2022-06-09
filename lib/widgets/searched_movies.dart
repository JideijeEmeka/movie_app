import 'package:flutter/material.dart';
import 'package:movie_app/helpers/constants.dart';
import 'package:movie_app/views/play_movie_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SearchedMovieList extends StatefulWidget {
  final List searching;

  const SearchedMovieList({Key? key, required this.searching}) : super(key: key);

  @override
  State<SearchedMovieList> createState() => _SearchedMovieListState();
}

class _SearchedMovieListState extends State<SearchedMovieList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: widget.searching.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      pushNewScreen(context, screen: PlayMovieView(
                        name: widget.searching[index]['title'],
                        bannerUrl: 'https://image.tmdb.org/t/p/w500'
                            + widget.searching[index]['backdrop_path'],
                        posterUrl: 'https://image.tmdb.org/t/p/w500'
                            + widget.searching[index]['poster_path'],
                        description: widget.searching[index]['overview'],
                        vote: widget.searching[index]['vote_average'].toString(),
                        launchOn: widget.searching[index]['release_date'],
                        language: widget.searching[index]['original_language'],
                        popularity: widget.searching[index]['popularity'].toString(),
                      sessionId: widget.searching[index]['id'].toString(),),
                          withNavBar: false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: MediaQuery(data: const MediaQueryData(padding: EdgeInsets.zero),
                        child: ListTile(
                          leading: Image.network('https://image.tmdb.org/t/p/w500'
                            + widget.searching[index]['poster_path'], fit: BoxFit.cover,),
                          title: Text(widget.searching[index]['title'], style: titleTextStyle,),
                          trailing: const Icon(Icons.play_circle_outline, color: Colors.white,),
                          tileColor: Colors.brown.withOpacity(0.4),
                          contentPadding: const EdgeInsets.only(left: 0.0, right: 20.0, top: 0.0, bottom: 0.0),
                        ),
                      ),
                    ),
                  );
                })
    );
  }
}
