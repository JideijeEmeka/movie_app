import 'package:flutter/material.dart';
import 'package:movie_app/helpers/constants.dart';

class Utility {
  Widget loader(BuildContext context, String title) {
    return Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 50),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                )),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(title, style: loadingTextStyle,),
            )
          ],
        ));
  }
}