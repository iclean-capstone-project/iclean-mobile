import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NotiContentLoadingWidget extends StatelessWidget {
  final double height;
  final double width;
  final ShapeBorder shapeBorder;

  const NotiContentLoadingWidget.rectangular({
    super.key,
    required this.height,
    this.width = double.infinity,
    this.shapeBorder = const RoundedRectangleBorder(),
  });

  const NotiContentLoadingWidget.circular({
    super.key,
    required this.height,
    required this.width,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade400,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: Colors.grey.shade400,
          shape: shapeBorder,
        ),
      ),
    );
  }
}
