import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_app/helpers/constants.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:overlay_support/overlay_support.dart';

class ConnectivityServiceController extends ControllerMVC {
  bool hasInternet = false;
  ConnectivityResult result = ConnectivityResult.none;

  checkInternetConnection() async {
    hasInternet = await InternetConnectionChecker().hasConnection;
    result = await Connectivity().checkConnectivity();
    final color = hasInternet ? Colors.green : Colors.red;
    final text = hasInternet ? 'Internet' : 'No Internet';

    if(result == ConnectivityResult.mobile) {
      showSimpleNotification(
          Text('$text: Mobile Network', style: titleTextStyle),
          background: color);
    }else if(result == ConnectivityResult.wifi) {
      showSimpleNotification(
          Text('$text: Wifi Network', style: titleTextStyle),
          background: color);
    }else {
      showSimpleNotification(
          Text('$text: No Network', style: titleTextStyle),
          background: color);
    }
  }

  ConnectivityServiceController();
}