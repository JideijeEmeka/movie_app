import 'package:flutter/material.dart';

class SeriesView extends StatefulWidget {
  const SeriesView({Key? key}) : super(key: key);

  @override
  State<SeriesView> createState() => _SeriesViewState();
}

class _SeriesViewState extends State<SeriesView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text('Coming soon')
      ),
    );
  }
}
