import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/helpers/constants.dart';

Widget floatButton() {
  return FloatingActionButton.extended(onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12)
    ),
  icon: const Icon(CupertinoIcons.shuffle),
  backgroundColor: Colors.white,
    foregroundColor: redColor,
    label: const Text("Play Something"),);
}