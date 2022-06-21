import 'package:flutter/material.dart';
import 'package:movie_app/helpers/constants.dart';

Widget floatButton(String title, Widget? icon) {
  return FloatingActionButton.extended(onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12)
    ),
  icon: icon,
  backgroundColor: Colors.white,
    foregroundColor: redColor,
    label: Text(title),);
}