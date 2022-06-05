import 'package:flutter/material.dart';
import 'package:movie_app/widgets/navigation_bar_widget.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return const WillPopScope(
      onWillPop: null,
      child: Scaffold(
        body: NavBar(),
      ));
  }
}
