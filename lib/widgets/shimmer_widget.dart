import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget.rectangular(
      {Key? key, this.width = double.infinity, required this.height})
      : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: (Colors.grey[400])!,
      highlightColor: (Colors.grey[300])!,
      child: Container(
        width: width,
        height: height,
        color: Colors.grey,
      ),
    );
  }
}
