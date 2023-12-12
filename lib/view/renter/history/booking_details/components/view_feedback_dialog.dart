import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/models/feedback.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:intl/intl.dart';

class ViewFeedbackDialog extends StatelessWidget {
  const ViewFeedbackDialog({
    super.key,
    required this.helperImage,
    required this.helperName,
    required this.feedback,
  });

  final String helperImage, helperName;
  final FeedbackModel feedback;

  Future<bool> isNetworkImageValid(String imageUrl) async {
    try {
      final response = await http.head(Uri.parse(imageUrl));
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      // Handle any exceptions, such as network errors
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                const Text(
                  "Đánh giá chất lượng dịch vụ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                  ),
                ),
                const SizedBox(height: 24),
                FutureBuilder<bool>(
                  future: isNetworkImageValid(helperImage),
                  builder: (context, snapshot) {
                    if (snapshot.hasError || !(snapshot.data ?? false)) {
                      // If the network image is invalid or there's an error, display the fallback asset image
                      return const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/default_profile.png'),
                        radius: 40,
                      );
                    } else {
                      return CircleAvatar(
                        backgroundImage: NetworkImage(helperImage),
                        radius: 40,
                      );
                    }
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  helperName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 1; i <= feedback.rate.toInt(); i++)
                      const Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  feedback.message,
                  style: const TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  DateFormat('d/MM/yyyy | HH:mm').format(feedback.timeCreated),
                  style: const TextStyle(
                    fontFamily: 'Lato',
                    color: ColorPalette.greyColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
