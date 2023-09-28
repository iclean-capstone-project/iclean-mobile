import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/view/renter/my_booking/components/completed_booking/components/my_timeline.dart';
import 'package:iclean_mobile_app/widgets/top_bar.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                const TopBar(text: "Chi tiết đơn"),
                const SizedBox(
                  height: 140,
                  child: MyTimeline(),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Service",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Lato',
                              ),
                            ),
                            Text(
                              "House Cleaning",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Lato',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Worker",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Lato',
                              ),
                            ),
                            Text(
                              "Lisa",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Date & Time",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Lato',
                              ),
                            ),
                            Text(
                              "Dec 23, 2024 | 10:00 AM",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Lato',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Working Hours",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Lato',
                            ),
                          ),
                          Text(
                            "2 Hours",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Lato',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "House Cleaning",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Lato',
                              ),
                            ),
                            Text(
                              "\$100",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Lato',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Promo',
                              style: TextStyle(
                                color: Colors.deepPurple.shade300,
                                fontSize: 14,
                                fontFamily: 'Lato',
                              ),
                            ),
                            Text(
                              "- \$20",
                              style: TextStyle(
                                color: Colors.deepPurple.shade300,
                                fontSize: 16,
                                fontFamily: 'Lato',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Total",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Lato',
                              ),
                            ),
                            Text(
                              "\$80",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Lato',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Date",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Lato',
                              ),
                            ),
                            Text(
                              "Dec 23, 2024 | 10:00 AM",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Lato',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Status",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Lato',
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "Paid",
                              style: TextStyle(
                                color: Colors.deepPurple.shade400,
                                fontSize: 15,
                                fontFamily: 'Lato',
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
