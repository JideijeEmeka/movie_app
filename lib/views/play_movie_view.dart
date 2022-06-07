import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app/helpers/constants.dart';

class PlayMovieView extends StatefulWidget {
  const PlayMovieView({Key? key}) : super(key: key);

  @override
  State<PlayMovieView> createState() => _PlayMovieViewState();
}

class _PlayMovieViewState extends State<PlayMovieView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.red,
      body: SingleChildScrollView(
        child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/movie_img2.png"),
              fit: BoxFit.fill)
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const ImageIcon(AssetImage("assets/images/back_button.png"),
                            color: Colors.white),
                      ),
                      Text("Overview", style: appBarTextStyle),
                      Container(width: 50)]),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Center(child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                        child: Image.asset("assets/images/movie_img2.png", fit: BoxFit.cover,))),
                  ),
                  Text("Black Widow", style: appBarTextStyle,),
                  const SizedBox(height: 5,),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Eng", style: subHeaderTextStyle,),
                        VerticalDivider(color: Colors.white.withOpacity(0.6), thickness: 2,),
                        Text("Action, Sci-Fi", style: subHeaderTextStyle,),
                        VerticalDivider(color: Colors.white.withOpacity(0.6), thickness: 2,),
                        Text("3hrs 10min", style: subHeaderTextStyle,),
                        VerticalDivider(color: Colors.white.withOpacity(0.6), thickness: 2,),
                        Text("PG", style: subHeaderTextStyle,),
                        VerticalDivider(color: Colors.white.withOpacity(0.6), thickness: 2,),
                        Image.asset("assets/images/star_rating.png"),
                        Text("7.4 IMDb", style: subHeaderTextStyle,),
                        VerticalDivider(color: Colors.white.withOpacity(0.6), thickness: 2,),
                      ],
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 10),
                      child: Text("Story line", style: titleTextStyle,),
                    ),
                    Text("Natasha Romanoff, aka Black Widow, confronts the "
                      "darker parts of her ledger when a dangerous "
                      "conspiracy with ties to her past arises. Pursued by a "
                      "force that will read more...", style: subHeaderTextStyle,),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      child: ElevatedButton(onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            textStyle: titleTextStyle,
                            primary: gradientRedColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10)),
                          child: const Text("Watch")),
                    )
                ],),
              ),
            ),
          ),
        ),
    );
  }
}
