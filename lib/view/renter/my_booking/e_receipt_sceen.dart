import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:iclean_mobile_app/widgets/top_bar.dart';

class EReceiptScreen extends StatelessWidget {
  final String barcodeData;
  const EReceiptScreen({Key? key, required this.barcodeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                //   child: Row(
                //     children: const [
                //       // InkWell(
                //       //   onTap: () {
                //       //     int count = 6;
                //       //     Navigator.of(context).popUntil((_) => count-- <= 0);
                //       //   },
                //       //   child: const Icon(Icons.arrow_back),
                //       // ),
                //       SizedBox(width: 20),
                //       Text(
                //         "E-Receipt",
                //         style: TextStyle(
                //           fontSize: 20,
                //           fontWeight: FontWeight.bold,
                //           fontFamily: 'Lato',
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                const TopBar(text: "Hóa đơn điện tử"),
                const SizedBox(height: 16),
                Text(
                  'Booking Code: $barcodeData',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Center(
                  child: BarcodeWidget(
                    barcode: Barcode.code128(),
                    data: barcodeData,
                    width: 200,
                    height: 100,
                    drawText: false,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                                fontSize: 16,
                                fontFamily: 'Lato',
                              ),
                            ),
                            Text(
                              "House Cleaning",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.bold,
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
                                fontSize: 16,
                                fontFamily: 'Lato',
                              ),
                            ),
                            Text(
                              "Lisa",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.bold,
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
                                fontSize: 16,
                                fontFamily: 'Lato',
                              ),
                            ),
                            Text(
                              "Dec 23, 2024 | 10:00 AM",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.bold,
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
                              fontSize: 16,
                              fontFamily: 'Lato',
                            ),
                          ),
                          Text(
                            "2 Hours",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
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
                    color: Colors.white,
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
                                fontSize: 16,
                                fontFamily: 'Lato',
                              ),
                            ),
                            Text(
                              "\$100",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.bold,
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
                                fontSize: 16,
                                fontFamily: 'Lato',
                              ),
                            ),
                            Text(
                              "- \$20",
                              style: TextStyle(
                                color: Colors.deepPurple.shade300,
                                fontSize: 16,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.bold,
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
                                fontSize: 16,
                                fontFamily: 'Lato',
                              ),
                            ),
                            Text(
                              "\$80",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.bold,
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
                                fontSize: 16,
                                fontFamily: 'Lato',
                              ),
                            ),
                            Text(
                              "Dec 23, 2024 | 10:00 AM",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.bold,
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
                              fontSize: 16,
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
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
