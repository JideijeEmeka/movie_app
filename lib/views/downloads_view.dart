import 'package:flutter/material.dart';

class DownloadsView extends StatefulWidget {
  const DownloadsView({Key? key}) : super(key: key);

  @override
  State<DownloadsView> createState() => _DownloadsViewState();
}

class _DownloadsViewState extends State<DownloadsView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Coming soon')
      ),
    );
  }
}
