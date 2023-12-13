import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/feedback.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:intl/intl.dart';

class FeedbackCard extends StatelessWidget {
  const FeedbackCard({super.key, required this.feedback});

  final FeedbackModel feedback;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(feedback.avatar),
                radius: 24,
              ),
            ],
          ),
          const SizedBox(
            height: 64,
            child: VerticalDivider(
              color: ColorPalette.greyColor,
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      feedback.name,
                      style: const TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat('d/MM/yyyy | HH:mm')
                          .format(feedback.timeCreated),
                      style: const TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 12,
                        color: ColorPalette.greyColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: List.generate(
                        feedback.rate.toInt(), // assuming rate is a double
                        (index) => const Icon(
                          Icons.star,
                          size: 18,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    if (feedback.rate % 1 != 0)
                      const Icon(
                        Icons.star_half,
                        size: 18,
                        color: Colors.orange,
                      ), // Half star
                    Row(
                      children: List.generate(
                        5 - feedback.rate.toInt(), // assuming rate is a double
                        (index) => const Icon(
                          Icons.star,
                          size: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  feedback.message,
                  style: const TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
