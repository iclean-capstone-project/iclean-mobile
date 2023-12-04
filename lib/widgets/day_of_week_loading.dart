import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/widgets/shimmer_loading.dart';

class DayOfWeekLoading extends StatelessWidget {
  const DayOfWeekLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorPalette.mainColor),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const ShimmerLoadingWidget.circular(height: 40, width: 40),
              const SizedBox(width: 16),
              ShimmerLoadingWidget.rectangular(
                height: 18,
                width: MediaQuery.of(context).size.width * 0.2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
