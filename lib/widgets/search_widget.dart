import 'package:flutter/material.dart';
import 'package:movie_app/helpers/constants.dart';

Widget searchWidget() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: OutlinedButton(onPressed: () {},
        style: OutlinedButton.styleFrom(
            side: BorderSide(color: redColor),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///Search Icon
            Row(children: [
              const Icon(Icons.search, color: Colors.white,),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("Search", style: normalTextStyle,),
              )
            ],),

            ///Record Audio
            Row(children: [
              Image.asset("assets/images/rect.png",
                color: Colors.white.withOpacity(0.3),),
              Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(Icons.mic_none_outlined,
                    color: Colors.white.withOpacity(0.4),)
              )
            ],),
          ],
        )),
  );
}