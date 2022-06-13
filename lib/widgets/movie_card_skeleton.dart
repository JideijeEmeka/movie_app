import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MovieCardSkeleton extends StatefulWidget {
  final List cards;
  const MovieCardSkeleton({Key? key, required this.cards}) : super(key: key);

  @override
  State<MovieCardSkeleton> createState() => _MovieCardSkeletonState();
}

class _MovieCardSkeletonState extends State<MovieCardSkeleton> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade50,
      enabled: true,
      child: SizedBox(
        height: 170,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: widget.cards.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(left: 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white),
                width: 116,
                height: 200,
              );
            }),
      ));
  }
}
