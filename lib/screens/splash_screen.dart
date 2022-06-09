import 'package:flutter/material.dart';
import 'package:movie_app/helpers/constants.dart';
import 'package:movie_app/views/dashboard_view.dart';
import 'package:movie_app/views/home_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
  _navigateToHome();
    super.initState();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    pushNewScreen(context, screen: const DashboardView(), withNavBar: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        child: Center(child: Text(appName, style: listTextStyle,),),
      ),
    );
  }
}
