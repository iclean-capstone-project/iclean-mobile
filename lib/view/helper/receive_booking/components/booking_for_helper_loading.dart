import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/widgets/shimmer_loading.dart';

class BookingForHelperLoading extends StatelessWidget {
  const BookingForHelperLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerLoadingWidget.rectangular(
                  height: 18,
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
                ShimmerLoadingWidget.rectangular(
                  height: 18,
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
              ],
            ),
            const Divider(
              color: ColorPalette.greyColor,
            ),
            Row(
              children: [
                const ShimmerLoadingWidget.circular(height: 80, width: 80),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoadingWidget.rectangular(
                      height: 18,
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                    const SizedBox(height: 4),
                    ShimmerLoadingWidget.rectangular(
                      height: 16,
                      width: MediaQuery.of(context).size.width * 0.6,
                    ),
                    const SizedBox(height: 4),
                    ShimmerLoadingWidget.rectangular(
                      height: 16,
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                    const SizedBox(height: 4),
                    ShimmerLoadingWidget.rectangular(
                      height: 16,
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                  ],
                ),
              ],
            ),
            const Divider(
              color: ColorPalette.greyColor,
            ),
            const ShimmerLoadingWidget.rectangular(height: 48)
          ],
        ),
      ),
    );
  }
}
