import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/helpers/constants.dart';
import 'package:movie_app/views/play_movie_view.dart';
import 'package:movie_app/widgets/favorite_movie_list_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 85, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              TextButton(onPressed: () {},
                  child: Text("TV Shows", style: titleTextStyle,)),
              TextButton(onPressed: () {},
                  child: Text("Movies", style: titleTextStyle,)),
              TextButton(onPressed: () {},
                  child: Text("Categories", style: titleTextStyle,)),
            ],),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Image.asset("assets/images/logo.png"),
          ),
          actions: [
            IconButton(onPressed: () {},
                padding: const EdgeInsets.only(right: 10),
                icon: const Icon(Icons.search_rounded, color: Colors.white,
                size: 30,)),
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
      ),
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          body: Stack(children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/movie_img.png"),
                    fit: BoxFit.fill),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.3, 0.7],
                      tileMode: TileMode.repeated,
                      colors: [Colors.transparent.withOpacity(0.2), Colors.black])
              ),
            ),
            SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 300),
                    Center(
                      child: Text("black hawk\n down".toUpperCase(),
                        style: headerTextStyle, textAlign: TextAlign.center)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Column(children: [
                          IconButton(onPressed: () {},
                              icon: const Icon(Icons.add, size: 30,
                                color: Colors.white,)),
                          Text("My List", style: normalTextStyle,),
                        ],),
                        ElevatedButton(onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 25),
                              onSurface: Colors.black54),
                            child: Row(children: const [
                              Icon(Icons.play_arrow, size: 30, color: Colors.black,),
                              Text("Play", style: TextStyle(color: Colors.black,
                                  fontSize: 17)),
                            ],)),
                          Column(children: [
                            IconButton(onPressed: () {},
                                icon: const Icon(Icons.info_outline, size: 30,
                                  color: Colors.white,)),
                            Text("Info", style: normalTextStyle,),
                          ],),
                      ],),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, left: 15,
                          right: 15, bottom: 10),
                      child: Text("My List", style: titleTextStyle,),),
                    CarouselSlider(items: [
                      FavoriteMovieList(),
                      FavoriteMovieList(),
                      FavoriteMovieList(),
                    ],
                        options: CarouselOptions(
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 5),
                            autoPlayAnimationDuration: const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                      child: Text("HitMan’s Wife’s BodyGuard", style: titleTextStyle,),),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            ImageIcon(const AssetImage("assets/images/star_rating.png"),
                              color: gradientRedColor, size: 40,),
                            Text("7.4", style: ratingTextStyle,),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text("IMDB", style: imdbTextStyle,),
                            ),
                          ],),
                          ElevatedButton(onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  primary: gradientRedColor,
                                  padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15)
                              ),
                              child: Row(children: [
                                const Icon(Icons.play_circle_filled, color: Colors.white,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text("Watch the Trailer", style: normalTextStyle,),
                                )
                              ],))
                        ],),
                    )
                  ],),
            )
          ]),
    );
  }
}
