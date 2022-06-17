import 'package:flutter/material.dart';
import 'package:movie_app/helpers/constants.dart';

SnackBar snackBar({required String message}) {
  return SnackBar(
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
      padding: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      content: Text(message, textAlign: TextAlign.center,
          style: loadingTextStyle));
}