import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/view/renter/my_booking/components/timeline.dart';
import 'package:iclean_mobile_app/widgets/top_bar.dart';


class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Column(
              children:  [
                 const TopBar(text: "Chi tiết đơn"),
                 ProcessTimelinePage()
              ],
            ),
          ),
        ),
      ),
    );
  }
}