import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/search_model.dart';
import 'package:tmdb_api/tmdb_api.dart';

class ApiServices {

  loader() {

  }

  // var data = [];
  // List<Search> results = [];
  //
  // String searchUrl = "https://jsonplaceholder.typicode.com/users/";
  //
  // Future<List<Search>> searchMovieList({String? query}) async {
  //   var url = Uri.parse(searchUrl);
  //   try {
  //     var response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       data = json.decode(response.body);
  //       results = data.map((e) => Search.fromJson(e)).toList();
  //       if(query != null) {
  //         results = results.where((element) =>
  //             element.name.toLowerCase().contains(query.toLowerCase())).toList();
  //       }
  //     } else {
  //       debugPrint('search error');
  //     }
  //   } on Exception catch (e) {
  //     debugPrint('error: $e');
  //   }
  //   return results;
  // }
}
