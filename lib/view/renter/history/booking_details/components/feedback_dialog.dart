import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/provider/loading_state_provider.dart';
import 'package:iclean_mobile_app/services/api_feedback_repo.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/renter/history/booking_details/booking_details_screen.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';
import 'package:provider/provider.dart';

class FeedbackDialog extends StatefulWidget {
  const FeedbackDialog({
    super.key,
    required this.id,
    required this.helperImage,
    required this.helperName,
    required this.booking,
  });

  final int id;
  final String helperImage, helperName;
  final Booking booking;

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  double _rating = 0;
  final TextEditingController _commentController = TextEditingController();

  Future<bool> isNetworkImageValid(String imageUrl) async {
    try {
      final response = await http.head(Uri.parse(imageUrl));
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      // Handle any exceptions, such as network errors
      return false;
    }
  }

  Future<void> _submitFeedback() async {
    String comment = _commentController.text.trim();

    if (_rating == 0) {
      _showErrorDialog("Bạn chưa đánh giá.");
    } else if (comment.isEmpty) {
      _showErrorDialog("Bạn chưa nhập nhận xét.");
    } else {
      final ApiFeedbackRepository repository = ApiFeedbackRepository();
      repository.feedback(context, widget.id, _rating, comment).then((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => BookingDetailsScreen(
                    booking: widget.booking,
                  )),
        );
      }).catchError((error) {
        // ignore: avoid_print
        print('Failed to feedback: $error');
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Lỗi',
            style: TextStyle(
              fontFamily: 'Lato',
            ),
          ),
          content: Text(
            message,
            style: const TextStyle(
              fontFamily: 'Lato',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final loadingState = Provider.of<LoadingStateProvider>(context);
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
                const SizedBox(height: 24),
                const Text(
                  "Đánh giá chất lượng dịch vụ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                  ),
                ),
                const SizedBox(height: 16),
                FutureBuilder<bool>(
                  future: isNetworkImageValid(widget.helperImage),
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
                        backgroundImage: NetworkImage(widget.helperImage),
                        radius: 40,
                      );
                    }
                  },
                ),
                const SizedBox(height: 4),
                Text(
                  widget.helperName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 1; i <= 5; i++)
                      IconButton(
                        icon: Icon(
                          i <= _rating ? Icons.star : Icons.star_border,
                          color: Colors.orange,
                        ),
                        onPressed: () {
                          setState(() {
                            _rating = i.toDouble();
                          });
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: _commentController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Đánh giá của bạn...',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: ColorPalette.mainColor,
                      ),
                    ),
                  ),
                  cursorColor: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(height: 16),
                MainColorInkWellFullSize(
                  onTap: () async {
                    loadingState.setLoading(true);
                    try {
                      await _submitFeedback();
                    } finally {
                      loadingState.setLoading(false);
                    }
                  },
                  text: "Gửi đánh giá",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
