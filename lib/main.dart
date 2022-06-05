import 'package:flutter/material.dart';
import 'package:movie_app/views/dashboard_view.dart';
import 'package:movie_app/views/home_view.dart';
import 'package:movie_app/widgets/navigation_bar_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: const DashboardView(),
    );
  }
}
