import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<String> ll = [];

/// App Name
String appName = "EmmyFlix";

/// App Colors
Color purpleColor = const Color(0xFF5D4176);
Color gradientOrangeColor = const Color(0xFFDF866C);
Color gradientRedColor = const Color(0xFFE03A14);
Color redColor = const Color(0xFFCB2F6B);

/// App TextStyles
final headerTextStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(color: Colors.white,
    fontSize: 24, fontWeight: FontWeight.w700));
final subHeaderTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(color: Colors.white.withOpacity(0.6),
    fontSize: 13, fontWeight: FontWeight.w400));
final descTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(color: Colors.white.withOpacity(0.8),
    fontSize: 13, fontWeight: FontWeight.w400));
final normalTextStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(color: Colors.white,
    fontSize: 14, fontWeight: FontWeight.w400));
final titleTextStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(color: Colors.white,
    fontSize: 17, fontWeight: FontWeight.w500));
final loadingTextStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(color: Colors.black,
    fontSize: 18, fontWeight: FontWeight.w500));
final ratingTextStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(color: Colors.white,
    fontSize: 17, fontWeight: FontWeight.w700));
final appBarTextStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(color: Colors.white,
    fontSize: 19, fontWeight: FontWeight.w700));
final listTextStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(color: Colors.white,
    fontSize: 18, fontWeight: FontWeight.w500));
final imdbTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(color: Colors.white.withOpacity(0.3),
    fontSize: 9, fontWeight: FontWeight.w400));

/// Api Keys and Access Token
String apiKey = "2a209b9033ad19c74ec7ab61c4cd582e";
String readAccessToken =  "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyYTIwOWI5MDMzYWQ"
    "xOWM3NGVjN2FiNjFjNGNkNTgyZSIsInN1YiI6IjYyYTBjMGJkN2UxMmYwNmUwNzdhNzk1MC"
    "IsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.nomF8AyiMxmk7R4nXfVmZ-"
    "j1LxM9zeW8qHhuN00iKaA";
